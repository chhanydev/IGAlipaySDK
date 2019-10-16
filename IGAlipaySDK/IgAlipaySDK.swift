//
//  IgAlipaySDK.swift
//  IGAlipaySDK
//
//  Created by Apple on 10/11/19.
//  Copyright © 2019 IG. All rights reserved.
//

import Foundation
public class AlipayInAppPayment
{
    private init(){}
    
    public static func startPayment<T:Codable>(device_id: String,total_fee: String,subject: String,body: String,preSign: String,success:@escaping (T) -> Void,failure:@escaping (String) -> Void)
    {
        // create timestamp
        let device_timestamp = "\(Date().currentTimeMillis())"
        
        // generate TradeNo
        
        let out_trade_no = AESUtils.instance.generateTradeNO()
        
        // create hash
        let hash = device_id+total_fee+subject+body+device_timestamp+preSign
        
        // convert hash to sha256
        let hashSha256 = hash.sha256().lowercased()
        
        let data = "body=\(body)&device_id=\(device_id)&device_timestamp=\(device_timestamp)&hash_key=\(hashSha256)&partner_tran_id=\(out_trade_no!)&status=pending&subject=\(subject)&total_fee=\(total_fee)"
        
        /// encryption aes256
        let encryptin = AESUtils.instance.encryptionAES(value: data, key256: Constant.KEY, iv: Constant.IV)
        
        /// start call backend for set status
        
        let myParam: [String: Any] = ["requestParams":encryptin]
        ApiService.shareInstance.requestPOSTURL(Constant.CROSS_BORDER_PAY, params: myParam, success: { (response: CrossPaymentResponse) in
            if response.response.code == Constant.success {
                /// do  update status
                
                let myData = response.data
                let totalFee = String(myData.total_fee)
                alipaySDKPayment(totalFee: totalFee, device: myData.device_id, out_trade_no: myData.out_trade_no, body: body, subject: subject)
                
            }
        }) { (err) in
            failure(err)
        }
    }
    public static func alipaySDKPayment(totalFee: String,device: String,out_trade_no:String,body: String,subject: String)
    {
      
        
         let order = Order()
        
        order.partner = Constant.partner
        order.sellerID = Constant.seller

        order.outTradeNO = AESUtils.instance.generateTradeNO() //"20181003001"
               order.subject = subject
               order.body = body
               order.totalFee = totalFee
               order.currency = "USD"
               order.notifyURL =  "https://alipay.site/test"
               order.service = "mobile.securitypay.pay"
               order.paymentType = "1"
               order.product_code = "NEW_WAP_OVERSEAS_SELLER"

               order.inputCharset = "utf-8"
               order.forex_biz = "FP"

               order.appenv = "system=android^version=0.0.1"

               let appScheme = "alisdkdemo"

            
        
    }
    
 
}
