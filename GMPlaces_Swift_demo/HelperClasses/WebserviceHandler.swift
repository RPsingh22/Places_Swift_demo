//
//  WebserviceHandler.swift
//  GMPlaces_Swift_demo
//
//  Created by Cerebrum on 30/01/17.
//  Copyright © 2017 Cerebrum. All rights reserved.
//
//@Class: This is use for get result from a url

import UIKit
import Alamofire

class WebserviceHandler: NSObject {
    typealias completionBlock = (AnyObject,Bool) -> Void
    typealias failureBlock = (NSString,Bool) -> Void
    
    func getRequest(urlString : String, requestDict : [String :AnyObject]?,compBlock : @escaping completionBlock,failure : @escaping failureBlock) -> Void
    {
        let completeUrlString : String =  urlString
        
        let urlStr = URL(string: completeUrlString)!
        
        DispatchQueue.global(qos: .background).async {
            
            request(urlStr as URLConvertible, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData(completionHandler: { response in
                do {
                    print(response.data!)
                    if let jsonResult = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String:AnyObject] {
                        compBlock(jsonResult as AnyObject,true)
                    }
                } catch {
                    // failure
                    let errorDesc = (error as NSError).localizedDescription
                    failure(errorDesc as NSString,false)
                }
            })
        }
    }
}
