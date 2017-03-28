//
//  EntityHelper.swift
//  Fruit
//
//  Created by 周敦广 on 2017/3/27.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import Alamofire

class EntityHelper {

    class func allFurits(_ succeed:(Any?)->(Void)){
        Alamofire.request("http://127.0.0.1:8000/getfruits").responseJSON { response in
            print(response.result)   // result of response serialization
        
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
}
