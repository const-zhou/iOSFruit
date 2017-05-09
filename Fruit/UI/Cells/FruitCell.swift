//
//  FruitCell.swift
//  Fruit
//
//  Created by 周敦广 on 2017/5/5.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import SDWebImage

class FruitCell: UITableViewCell{
    var disposeBag = DisposeBag()
    var viewModel : Variable<FruitEntity> = Variable<FruitEntity>.init(FruitEntity.init()){
        didSet{
            _ = viewModel.asObservable().observeOn(MainScheduler.instance)
            .subscribe({ [unowned self] (event) in
                if let entity = event.element {
                    self.name.text = entity.name
                    self.abstract.text = entity.description
                    if let imageUrl = entity.imageUrl{
                        self.fruitImageView.sd_setImage(with: URL.init(string: imageUrl))
                    }
                }
            })
            .addDisposableTo(disposeBag)
        }
    }
    
    let name : UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let abstract: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    let fruitImageView :UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setupSubViews() -> Void {
        self.contentView.addSubview(name)
        self.contentView.addSubview(abstract)
        self.contentView.addSubview(fruitImageView)
        
        fruitImageView.snp.makeConstraints({ (make) in
            make.leading.equalTo(self.snp.leading).offset(8)
            make.top.equalTo(self.snp.top).offset(8)
            make.bottom.equalTo(self.snp.bottom).offset(-50)
            make.width.equalTo(self.snp.height).offset(-16)
        })
        name.snp.makeConstraints { (make) in
            make.leading.equalTo(fruitImageView.snp.leading)
            make.trailing.equalTo(fruitImageView.snp.trailing)
            make.top.equalTo(fruitImageView.snp.bottom).offset(10)
        }
        abstract.snp.makeConstraints { (make) in
            make.leading.equalTo(fruitImageView.snp.trailing).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-8)
            make.top.equalTo(self.snp.top).offset(8)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
        }
    }
    
    override func prepareForReuse() {
        name.text = ""
        abstract.text = ""
        fruitImageView.image = nil
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
