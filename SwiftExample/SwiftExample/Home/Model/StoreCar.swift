//
//  StoreCar.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/11/8.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class StoreCar: NSObject {
    /*!
     * @brief 满减
     */
    var chargeType: String = "";
    /*!
     * @brief 已购满99元, 可领取赠品
     */
    var charge: String = "";
    /*!
     * @brief 领赠品>
     */
    var getFree: String = "";
    /*!
     * @brief 是否勾选
     */
    var isChose = false;
    /*!
     * @brief 商品图
     */
    var bigImage: String = "";
    /*!
     * @brief 名称
     */
    var name: String = "";
    /*!
     * @brief 颜色:玫瑰金
     */
    var colorText: String = "";
    /*!
     * @brief 4018.00
     */
    var money = 0.0;
    /*!
     * @brief 数量
     */
    var count = 1;
    
}
