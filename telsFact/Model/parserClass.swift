//
//  parserClass.swift
//  sivarajexercise2
//
//  Created by Wipro on 22/06/18.
//  Copyright © 2018 Wipro. All rights reserved.
//

import UIKit

class parserClass: NSObject {
    func parseObj(dict:Dictionary<AnyHashable, Any>) -> Array<Any> {
        var anarray :Array<Any> = []
       let rowarray = dict["rows"] as! Array<Any>
        for check in 1..<rowarray.count{
            let obj = objectCollected()
            let dict1 = rowarray[check] as! Dictionary<AnyHashable,Any>
            if let name = dict1["title"] as? String {
                obj.name = name
            }else{
                obj.name = ""
            }
            if let descrip = dict1["description"] as? String {
                obj.descrip = descrip
            }else{
                obj.descrip = ""
            }
            if let image = dict1["imageHref"] as? String {
                obj.image = image
            }else{
                obj.image = ""
            }
            anarray.append(obj)
        }
     return anarray
    }
    
   
}



