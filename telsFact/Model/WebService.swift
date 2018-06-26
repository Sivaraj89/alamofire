//
//  WebService.swift
//  sivarajexercise2
//
//  Created by Wipro on 22/06/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

protocol serviceCalls{
    func serviceDict(dict:Dictionary<AnyHashable, Any>)
}

class WebService: NSObject {
    var service: serviceCalls?
   func webCall(webUrl:String) {
     let url = URL(string:webUrl)
    Alamofire.request(url!).responseJSON { response in
        print("Response: \(String(describing: response.data))") // http url response
        if(response.data == nil)
                {
                    print("Unable to reach server")
                    return
                }
                let responseString = String(data: response.data!, encoding: .isoLatin1)
                let dutf8: Data? = responseString?.data(using: .utf8)
                var dict: [AnyHashable: Any]? = nil
                if let aDutf8 = dutf8 {
                        dict = try! JSONSerialization.jsonObject(with: aDutf8, options: .mutableContainers) as? [AnyHashable: Any]
                    self.service?.serviceDict(dict: dict!)
                }
        }


    }
}
