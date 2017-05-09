//
//  ForecastsView.swift
//  Fruit
//
//  Created by 周敦广 on 2017/5/8.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ForecastsView: UIView {
    var viewModel:Variable<[Forecast]> = Variable.init([]){
        didSet{
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
            .subscribe { [unowned self] (event) in
                if let entitys = event.element{
                    self.setupWeatherItemViews(entitys)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWeatherItemViews(_ forecasts: [Forecast]) -> Void {
        _ = self.subviews.map{$0.removeFromSuperview()}
        for (index, item) in forecasts.enumerated(){
            if index > 2 {
                break
            }
            let itemView = ForecastItemView.init(frame: .zero)
            self.addSubview(itemView)
            itemView.viewModel = Variable<Forecast>.init(item)
            itemView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.snp.top)
                make.leading.equalTo(self.snp.leading).offset(index * 80)
                make.width.equalTo(70)
                make.height.equalTo(150)
            })
        }
    }
    
}
