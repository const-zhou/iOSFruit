//
//  ForecastItemView.swift
//  Fruit
//
//  Created by 周敦广 on 2017/5/8.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ForecastItemView: UIView{
    let time: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.black
        return label
    }()
    let iconText: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.init(name: "Weather Icons", size: 30)
        return label
    }()
    let temp: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.black
        return label
    }()
    
    var viewModel: Variable<Forecast> = Variable<Forecast>.init(Forecast.init()){
        didSet{
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
                .subscribe({ [unowned self] (event) in
                    if let entity = event.element{
                        self.time.text = "\(entity.hour)"
                        self.iconText.text = WeatherIcon.init(condition: entity.id!, iconString: entity.icon!).iconText
                        self.temp.text = "\(entity.temperature!)°C"
                    }
                })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        self.addSubview(time)
        self.addSubview(iconText)
        self.addSubview(temp)
        
        time.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(10)
            make.centerX.equalTo(self.snp.centerX)
        }
        iconText.snp.makeConstraints { (make) in
            make.top.equalTo(time.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
        }
        temp.snp.makeConstraints { (make) in
            make.top.equalTo(iconText.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    
}
