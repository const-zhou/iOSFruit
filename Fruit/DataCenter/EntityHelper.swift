//
//  EntityHelper.swift
//  Fruit
//
//  Created by 周敦广 on 2017/3/27.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class EntityHelper {

    class func allFurits(_ succeed:@escaping (AnyObject?)->(Void)){
        Alamofire.request("http://127.0.0.1:8000/getfruits").responseJSON { response in
            print(response.result)   // result of response serialization
        
            if let JSON = response.result.value {
//                print("JSON: \(JSON)")
                succeed(JSON as AnyObject?)
            }
        }
    }
    
    class func furtesObservable()->(Observable<Any>) {
         return Observable<Any>.create({ (jsonObj) -> Disposable in
            Alamofire.request("http://127.0.0.1:8000/getfruits").responseJSON { response in
                print(response.result)   // result of response serialization
                if let JSON = response.result.value {
                    jsonObj.onNext(JSON)
                }
                jsonObj.onCompleted()
            }
            return Disposables.create()
         })
    }
}
