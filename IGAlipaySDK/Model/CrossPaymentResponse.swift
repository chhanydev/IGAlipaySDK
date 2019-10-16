//
//  CrossPaymentResponse.swift
//  IGAlipaySDK
//
//  Created by Apple on 10/11/19.
//  Copyright © 2019 IG. All rights reserved.
//

import Foundation
struct CrossPaymentResponse: Codable {
    var response: ErrorResponse
    var data: DataCrossPayment
}
struct DataCrossPayment: Codable {
    var id: Int
    var device_id: String
    var out_trade_no: String
    var total_fee: Double
    var status: String
    var sign_order_info: String
    
    init(id: Int,device_id: String,out_trade_no: String,total_fee: Double,status: String,sign_order_info: String) {
        self.id = id
        self.out_trade_no = out_trade_no
        self.total_fee = total_fee
        self.status = status
        self.device_id = device_id
        self.sign_order_info = sign_order_info
    }
}
struct ErrorResponse: Codable {
    let code: String
    var message: String
    init(code: String,message: String) {
        self.code = code
        self.message = message
    }
}
