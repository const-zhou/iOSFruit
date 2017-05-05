//
//  FruitViewModel.swift
//  Fruit
//
//  Created by 周敦广 on 2017/5/4.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class FruitViewModel{
    private let provide = RxMoyaProvider<FruitService>()
    
    func allFruits() -> Observable<[FruitEntity]>{
        return provide.request(.allFruts)
        .filterSuccessfulStatusCodes()
        .mapJSON()
        .mapArray(type: FruitEntity.self)
    }
}
