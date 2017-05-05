//
//  FuritService.swift
//  Fruit
//
//  Created by 周敦广 on 2017/5/4.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import Moya

enum FruitService{
    case allFruts
}

extension FruitService: TargetType{
    var baseURL: URL{return URL(string: "http://127.0.0.1:8000")!}
    var path: String{
        switch self {
        case .allFruts:
            return "/getfruits"
        }
    }
    var method: Moya.Method{
        switch self {
        case .allFruts:
            return .get
        }
    }
    var parameters: [String:Any]?{
        switch self {
        case .allFruts:
            return nil
        }
    }
    var parameterEncoding: ParameterEncoding{
        switch self {
        case .allFruts:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data{
        switch self {
        case .allFruts:
            return "no data".utf8Encoded;
        }
    }
    
    var task: Task{
        switch self {
        case .allFruts:
            return .request
        }
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
