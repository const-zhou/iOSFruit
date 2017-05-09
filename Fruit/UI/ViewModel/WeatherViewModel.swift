//
//  WeatherViewModel.swift
//  Fruit
//
//  Created by 周敦广 on 2017/5/8.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class WeatherViewModel{
    private let provide = RxMoyaProvider<WeatherService>()
    func todayWeather() -> Observable<Weather> {
        return provide.request(.todayForCity(city: "beijing"))
        .filterSuccessfulStatusCodes()
        .mapJSON()
        .mapObject(type: Weather.self)
    }
    
    func forecast() -> Observable<[Forecast]> {
        return provide.request(.dailyForCity(city: "beijing"))
        .filterSuccessfulStatusCodes()
        .mapJSON()
        .map({ (json) -> [Any] in
            guard json is [String: Any] else{
                return []
            }
            let dict = json as! [String: Any]
            return dict["list"] as! [Any]
        })
        .mapArray(type: Forecast.self)
    }
}
