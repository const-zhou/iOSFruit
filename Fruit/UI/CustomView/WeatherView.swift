//
//  WeatherView.swift
//  Fruit
//
//  Created by 周敦广 on 2017/5/8.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class WeatherView: UIView{
    let city: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        return label
    }()
    
    let iconText: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Weather Icons", size: 30)
        return label
    }()
    
    let temp: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let desc: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    var viewModel: Variable<Weather> = Variable<Weather>.init(Weather.init()){
        didSet{
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
                .subscribe({ [unowned self] (event) in
                    if let entity = event.element{
                        self.city.text = entity.location
                        self.iconText.text = WeatherIcon.init(condition: entity.id!, iconString: entity.icon!).iconText
                        self.temp.text = "\(String(describing: entity.temperature!))°C"
                        self.desc.text = entity.description
                    }
                })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() -> Void{
        self.addSubview(city)
        self.addSubview(iconText)
        self.addSubview(temp)
        self.addSubview(desc)
        city.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalTo(self.snp.centerX)
        }
        iconText.snp.makeConstraints { (make) in
            make.top.equalTo(city.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
        }
        temp.snp.makeConstraints { (make) in
            make.top.equalTo(iconText.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX).offset(15)
        }
        desc.snp.makeConstraints { (make) in
            make.top.equalTo(iconText.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX).offset(-15)
        }
    }
    
}
