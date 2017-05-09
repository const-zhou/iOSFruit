//
//  FruitEntity.swift
//  Fruit
//
//  Created by 周敦广 on 2017/3/27.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift
import RxDataSources

class FruitSectionEntity: Mappable{
    var title :String?
    var detail :String?
    var imageUrl :String?
    var itemType :Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title     <- map["section"]
        detail    <- map["content"]
        itemType  <- map["itemType"]
        imageUrl  <- map["image"]
    }
}

class FruitEntity: Mappable {
    var name :String? = String()
    var description :String? = String()
    var imageUrl :String? = String()
    var sectionList:[FruitSectionEntity]?
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func fruitImageUrl() -> String? {
//        let contentImageEntityArray = sectionList?.filter({ (entity) -> Bool in
//            return (entity.imageUrl != nil)
//        })
//        if (contentImageEntityArray?.count)! > 0 {
//            return contentImageEntityArray![0].imageUrl!
//        }
//        return ""
        return imageUrl
    }
    
    func mapping(map: Map) {
        name        <- map["name"]
        description <- map["description"]
        sectionList <- map["section_list"]
        imageUrl    <- map["imageUrl"]
    }
    
}
extension FruitEntity: Equatable{
    public static func ==(lhs: FruitEntity, rhs: FruitEntity) -> Bool{
        return lhs.name == rhs.name
    }
}

struct SectionOfFruitData {
    var header : String
    var items : [FruitEntity]
}

extension SectionOfFruitData : SectionModelType{
    init(original: SectionOfFruitData, items: [SectionOfFruitData.Item]) {
        self = original
        self.items = items
    }
}



extension Observable{
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T>{
        return self.observeOn(SerialDispatchQueueScheduler.init(qos: .background)).map{ response -> T in
            guard let dict = response as? [String: Any] else{
                throw RxSwiftMoyaError.ParseJSONError
            }
            return Mapper<T>().map(JSON: dict)!
        }.observeOn(MainScheduler.instance)
    }
    
    func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]>{
        return self.observeOn(SerialDispatchQueueScheduler.init(qos: .background)).map{ response in
            guard let array = response as? [Any] else{
                throw RxSwiftMoyaError.ParseJSONError
            }
            guard let dicts = array as? [[String: Any]] else{
                throw RxSwiftMoyaError.ParseJSONError
            }
            return Mapper<T>().mapArray(JSONArray: dicts)!
        }.observeOn(MainScheduler.instance)
    }
}

enum RxSwiftMoyaError: String{
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error{}
