//
//  ApiService.swift
//  IGAlipaySDK
//
//  Created by Apple on 10/11/19.
//  Copyright © 2019 IG. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class ApiService: NSObject {
    static var shareInstance = ApiService()
    
   func requestPOSTURL<T:Codable>(_ strURL : String, params : [String : Any]?, success:@escaping (T) -> Void, failure:@escaping (String) -> Void){
  //  let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                guard let data = responseObject.data else { return }
                
                let json = JSON(data)
                 print("json \(json)")
                do {
                    let recoment =  try JSONDecoder().decode(T.self, from: data)
                    success(recoment)
                }catch {
                    failure(responseObject.result.error?.localizedDescription ?? "")
                }
            }else {
                failure(responseObject.error?.localizedDescription ?? "Error")
            }
           
        }
    }
    
}
