//
//  AESUtils.swift
//  IGAlipaySDK
//
//  Created by Apple on 10/11/19.
//  Copyright © 2019 IG. All rights reserved.
//

import Foundation
import CryptoSwift
class AESUtils:NSObject {
    
    static var instance = AESUtils()
            
    func encryptionAES(value: String,key256: String,iv: String) -> String {
     
               let input: [UInt8] = Array(value.utf8)

               let myIv: [UInt8] = Array(iv.utf8)
               let myKey: [UInt8] = Array(key256.utf8)
               
               do {
                   let encrypted = try AES(key: myKey, blockMode: CBC(iv: myIv), padding: .pkcs7).encrypt(input)
                 // print("Result: \(encrypted.toBase64())")
                return encrypted.toBase64() ?? ""
               } catch {
                   print(error)
               }
        
        return ""
          
    }
        
    
    let generateTradeNOKNumber = 15
        
        func generateTradeNO() -> String? {
            
            let sourceStr = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            var resultStr = ""
            // srand(UInt(time(0)))
            for _ in 0..<self.generateTradeNOKNumber {
                let index = UInt(Int(arc4random()) % sourceStr.count)
                let oneStr = (sourceStr as NSString).substring(with: NSRange(location: Int(index), length: 1))
                resultStr += oneStr
            }
            return resultStr
        }
   
}
