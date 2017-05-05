//
//  ViewController.swift
//  Fruit
//
//  Created by 周敦广 on 2017/3/27.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import UIKit
import SnapKit
import Moya
import RxSwift
import RxDataSources
import RxCocoa

//private typealias FruitSectionModel = AnimatableSectionModel<String, FruitEntity>

class ViewController: UIViewController {
    let flowLayout = CardCollectionFlowLayout.init()
    lazy var collectionView = UICollectionView()
    var dataArray:[String] = []
    var disposeBag : DisposeBag = DisposeBag()
    let viewModel = {
        return FruitViewModel()
    }()
    
    lazy var tableView = { () -> UITableView in 
        let tableView = UITableView.init()
        tableView.delegate = nil
        tableView.dataSource = nil
        return tableView
    }()
    
    private let dataSource = RxTableViewSectionedReloadDataSource<SectionOfFruitData>()
    
    func initDataArray() -> [String] {
        if dataArray.count > 0 {
            return dataArray
        }else{
            for i in 0..<20{
                dataArray.append("\(i)")
            }
        }
        return dataArray
    }
    
//    var dataSource : Variable<Any>
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = RxMoyaProvider<FruitService>()
        _ = provider.request(.allFruts).filterSuccessfulStatusCodes().mapJSON().mapArray(type: FruitEntity.self)
            .subscribe(onNext: {(entitys : [FruitEntity]) in
                print(entitys.count)
        })
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(self.view.snp.top).offset(100)
            make.height.equalTo(180)
        }
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(40)
            make.bottom.equalToSuperview()
        }
        
        collectionView.register(CardCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cardCell")
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "baseCell")
        dataArray = initDataArray()
        self.collectionView.reloadData()
        
        
        dataSource.configureCell = { (dataSource, tableView, IndexPath, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "baseCell")!
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.description
            return cell
        }
        dataSource.canEditRowAtIndexPath = {_ in true}
        
        viewModel.allFruits().map{[SectionOfFruitData(header: "", items: $0)]}
            .bind(to: tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

extension ViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        cell.index = dataArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detialVC = FruitDetailViewController()
        detialVC.title = "\(indexPath.row)"
        self.present(detialVC, animated: true) { 
            
        }
    }
}

extension ViewController:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        flowLayout.invalidateLayout()
    }
}

