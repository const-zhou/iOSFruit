//
//  Weather.swift
//  Fruit
//
//  Created by 周敦广 on 2017/5/8.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift


class Weather: Mappable {
    var location: String?
    var iconText: String?
    var description: String?
    var temperature: Int?
    var forecasts: [Forecast]?
    var id: Int?
    var icon: String?
    
    init(location: String, iconText: String, temperature: Int, forecasts: [Forecast]) {
        self.location = location
        self.iconText = iconText
        self.temperature = temperature
        self.forecasts = forecasts
    }
    
    required init?(map: Map){
        
    }
    
    init(){
        
    }
    
    func mapping(map: Map) {
       location        <- map["name"]
        id             <- map["weather.0.id"]
        icon           <- map["weather.0.icon"]
        description    <- map["weather.0.description"]
        temperature    <- map["main.temp"]
    }
}
