//
//  FruitEntity.swift
//  Fruit
//
//  Created by 周敦广 on 2017/3/27.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation

class FruitEntity {
    var name :String? = String()
    var description :String? = String()
    var sectionList:[AnyObject]? = Array()
    
    init(){
        
    }
    
    init(dict:[String:AnyObject]) {
        self.name = dict["name"] as? String
        self.description = dict["description"] as? String
        self.sectionList = dict["section_list"] as? Array
    }
    
    func convert2Dictionary() -> [String:AnyObject]{
        return ["name":self.name! as AnyObject,
                "description":self.description! as AnyObject,
                "sectionList":self.sectionList! as AnyObject
        ]
    }
    
    
}
