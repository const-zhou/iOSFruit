//
//  CardCollectionViewCell.swift
//  Fruit
//
//  Created by 周敦广 on 2017/3/28.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CardCollectionViewCell: UICollectionViewCell {
    var index = "" {
        didSet{
            label.text = "index \(index)"
        }
    }
    lazy var label = UILabel()
    
    func randomColor() -> UIColor {
        return UIColor.init(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = randomColor()
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
