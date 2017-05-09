//
//  Forecast.swift
//  Fruit
//
//  Created by 周敦广 on 2017/5/8.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

class Forecast: Mappable{
    var time: Date?
    var iconText: String?
    var temperature: Int?
    var id: Int?
    var icon: String?
    var hour: String{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
            return dateFormatter.string(from: time!)
        }
    }
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        time    <- (map["dt"], DateTransform())
        temperature  <- map["main.temp.temp"]
        id      <- map["weather.0.id"]
        icon    <- map["weather.0.icon"]
    }
}
