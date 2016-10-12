//
//  BankCard.swift
//  SwiftExample
//
//  Created by 李云鹏 on 16/10/11.
//  Copyright © 2016年 yunPeng. All rights reserved.
//

import UIKit

class BankCard: NSObject {
    /*!
     * @brief 提现方式 bank/credit/alipay/wechat
     */
    var type: String = "";
    /*!
     * @brief 机构名称如ABC
     */
    var org: String = "";
    /*!
     * @brief 账号
     */
    var number: String = "";
    /*!
     * @brief 账户名
     */
    var name: String = "";
}
