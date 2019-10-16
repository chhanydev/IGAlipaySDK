//
//  My+Extention.swift
//  IGAlipaySDK
//
//  Created by Apple on 10/11/19.
//  Copyright © 2019 IG. All rights reserved.
//

import Foundation
extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    
}
