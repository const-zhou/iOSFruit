//
//  WeatherService.swift
//  Fruit
//
//  Created by 周敦广 on 2017/5/8.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import Moya

enum WeatherService {
    case todayForCoordinate(lon: Float, lat: Float)
    case todayForCity(city: String)
    case dailyForCorrdinate(lon: Float, lat: Float)
    case dailyForCity(city: String)
}

extension WeatherService: TargetType{
    var baseURL: URL{ return URL(string: "http://api.openweathermap.org")!}
    var path: String{
        switch self {
        case .todayForCity( _), .todayForCoordinate( _, _):
            return "data/2.5/weather"
        case .dailyForCity(_), .dailyForCorrdinate(_, _):
            return "data/2.5/forecast"
        }
    }
    var method: Moya.Method{
        switch self {
        case .todayForCity(_), .todayForCoordinate(_, _):
            return .get
        case .dailyForCorrdinate(_, _), .dailyForCity(_):
            return .get
        }
    }
    var parameters: [String:Any]?{
        switch self {
        case .todayForCity(let city):
            return ["q": city, "appid":"5e084ac84b6aa97daa42e0b9a9a2ad22", "lang":"zh_cn", "units":"metric"]
            
        case .todayForCoordinate(let lon, let lat):
            return ["lat": lat, "lon": lon, "appid":"5e084ac84b6aa97daa42e0b9a9a2ad22", "lang":"zh_cn", "units":"metric"]
        case .dailyForCity(let city):
            return ["q": city, "appid":"5e084ac84b6aa97daa42e0b9a9a2ad22", "lang":"zh_cn", "units":"metric"]
        case .dailyForCorrdinate(let lon, let lat):
            return ["lat": lat, "lon": lon, "appid":"5e084ac84b6aa97daa42e0b9a9a2ad22", "lang":"zh_cn", "units":"metric"]
        }
    }
    var sampleData: Data{
        switch self {
        case .todayForCity(_), .todayForCoordinate(_, _):
            return "no data".utf8Encoded
        case .dailyForCity(_), .dailyForCorrdinate(_, _):
            return "no data".utf8Encoded
        }
    }
    var parameterEncoding: ParameterEncoding{
        return URLEncoding.default
    }
    
    var task: Task{
        return .request
    }
}

private extension String{
    var urlEscaped: String{
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data{
        return self.data(using: .utf8)!
    }
}
