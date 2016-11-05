//
//  NSObject+Model.swift
//  SwiftModel
//
//  Created liwei on 16/7/8.
//  Copyright © 2016年 SmithDavid. All rights reserved.
//

import Foundation

/**
 数据类型
 */
enum ValueType {
    case number
    case string
    case bool
    case array
    case dictionary
    case null
    case unknow
}


extension NSObject {
    
    // MARK: - 模型中有个数组属性，数组里面又要装着其他模型 (子类重写)
    func objectClassInArray() -> [String : AnyClass]? {
        return nil
    }
    
    // MARK: - 模型中的属性名和字典中的key不相同（子类重写）
    class func replacedKeyFromVariableName() -> [String : String]? {
        return nil
    }
    
    // MARK: - 模型中包含其他自定义模型，通过该方法返回自定义类类名（子类重写）
    class func customClassForVariableName() -> [String : AnyClass]? {
        return nil
    }
    
    // MARK: - 字典转模型
    class func objectWithDictionary(_ dict:[String : AnyObject]) -> NSObject {
        
        // 创建一个对象
        let model = self.init()
        
        let variables = getAllVariables()
        // 赋值
        model.setValues(variables, dict: dict)
        
        // 返回赋值好的对象
        return model
    }
    
    
    // MARK: - 把一个字典数组转成一个模型数组
    class func objectArrayWithDictionaryArray(_ array:NSArray) -> [AnyObject]{
        var tempArray = [AnyObject]()
        
        let variables = getAllVariables()
        
        for i in 0..<array.count {
            let keyValues = array[i] as? NSDictionary
            
            if let dict = keyValues {
                let model = self.init()
                // 为每个model赋值
                model.setValues(variables, dict: dict as! [String : AnyObject])
                tempArray.append(model)
            }
        }
        return tempArray
    }
    
    // MARK: - 核心方法
    fileprivate func setValues(_ variables:[Variable]?, dict:[String : AnyObject]) {
        
        // properties有值
        if let variableArray = variables {
            
            // 取出propertyArray中的property
            for variable in variableArray {
                
                /// 根据property的key从字典中取值
                if let value = dict[variable.key] {
                    
                    // 判断value的类型，根据类型进行赋值
                    let type = getType(value)
                    
                    // 是基本类型，直接赋值
                    if isBasicType(type) {
                        
                        setValue(value,forKey: variable.name)
                    } else if type == .dictionary { // 类型是个字典（自定义类）
                        
                        // 获得自定义类的类名
                        let modelClassDict = self.classForCoder.customClassForVariableName()
                        if let classDict = modelClassDict {
                            
                            let modelClass:AnyClass = classDict[variable.key]!
                            
                            let subModel = modelClass.objectWithDictionary(value as! [String : AnyObject])
                            
                            setValue(subModel, forKey: variable.name)
                        }
                        
                    } else if type == .array { // 类型是个数组
                        
                        if let array = value as? [AnyObject] {
                            
                            let obj = array.first
                            
                            let valueType = getType(obj)
                            
                            if isBasicType(valueType) {
                                setValue(array, forKey: variable.name)
                            } else {
                                
                                let modelClassDict = objectClassInArray()
                                
                                if let classDict = modelClassDict {
                                    
                                    let modelClass:AnyClass? = classDict[variable.key]
//                                    let modelArray  = modelClass?.objectArrayWithDictionaryArray(array)
                                    let modelArray  = modelClass?.objectArrayWithDictionaryArray(array as NSArray)
                                    setValue(modelArray, forKey: variable.name)
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    // 获得所有属性
    fileprivate class func getAllVariables() -> [Variable]? {
        
        // 获取类本身的名称
        let className = NSString(cString: class_getName(self), encoding: String.Encoding.utf8.rawValue) as? String
        
        if let name = className {
            
            // 判断类型名称，NSObject不用进行获取和赋值
            if name == "NSObject" {
                return nil
            }
            
        } else {    // 名字为空，获取不到类名
            return nil
        }
        
        // 初始化一个变量数组
        var variableArray = [Variable]()
        
        var count:UInt32 = 0
        
        // 获得该类所有的成员变量
        let ivarList = class_copyIvarList(self.classForCoder(), &count)
        
        
        // 获得父类的所有属性
        let superVariables = (self.superclass() as! NSObject.Type).getAllVariables()
        
        // 整合所有属性
        if let superV = superVariables {
            variableArray += superV
        }
        
        // 获取属性名与key不同的字典
        let replacedDict = replacedKeyFromVariableName()
        
        
        // 获得成员变量名  放到数组中
        for i in 0..<Int(count) {
            
            let ivar = ivarList?[i]
            
            let nameStr = NSString(utf8String: ivar_getName(ivar)) as! String
            
            let variable = Variable(name: nameStr)
            
            if let dict = replacedDict {
                
                //判断是否有映射
                if let key = dict[variable.name] {
                    
                    variable.key = key
                }
            }
            variableArray.append(variable)
        }
        
        return variableArray
    }
    
    
    // 获取value的类型
    fileprivate func getType(_ value:AnyObject?) -> ValueType{
        
        if value == nil {
            return .null
        }
        
        switch value{
            
            case let number as NSNumber:
                if number.model_isBool {
                    return .bool
                } else {
                    return .number
                }
            
            case _ as String:
                return .string
            
            case _ as [AnyObject]:
                return .array
            
            case _ as [String : AnyObject]:
                return .dictionary
            
            default:
                return .unknow
        }
    }
    
    
    /**
     是否为基础类型
     
     - parameter type: 类型
     
     - returns: true/false
     */
    fileprivate func isBasicType(_ type:ValueType) -> Bool{
        if type == .bool || type == .string || type == .number {
            return true
        }
        return false
    }
}

class Variable {
    
    // 属性key
    var key:String!
    
    // 属性名
    var name:String!
    
    init(name n :String!) {
        name = n
        key = name
    }
    
}



private let trueNumber = NSNumber(value: true as Bool)
private let falseNumber = NSNumber(value: false as Bool)
private let trueObjCType = String(cString: trueNumber.objCType)
private let falseObjCType = String(cString: falseNumber.objCType)
// MARK: - 判断是否为bool(swift中，Bool类型的根本是 NSNumber)
extension NSNumber {
    var model_isBool:Bool {
        get {
            let objCType = String(cString: self.objCType)
            if (self.compare(trueNumber) == ComparisonResult.orderedSame && objCType == trueObjCType)
                || (self.compare(falseNumber) == ComparisonResult.orderedSame && objCType == falseObjCType){
                return true
            } else {
                return false
            }
        }
    }
}
