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
        tableView.delegate = self
        tableView.dataSource = nil
        return tableView
    }()
    
    lazy var weatherView: WeatherView = {
        let view = WeatherView.init(frame: .zero)
        return view
    }()
    
    lazy var forecastsView: ForecastsView = {
        let view = ForecastsView.init(frame: .zero)
        return view
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
        self.title = "水果"
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = .init(rawValue: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
//        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.snp.makeConstraints { (make) in
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.top.equalTo(self.view.snp.top).offset(100)
//            make.height.equalTo(180)
//        }
        
        self.view.addSubview(self.weatherView)
        weatherView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(10)
            make.leading.equalTo(self.view.snp.leading).offset(15)
            make.width.equalTo(70)
            make.height.equalTo(120)
        }
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(self.view.snp.top).offset(110)
            make.bottom.equalToSuperview()
        }
        
        self.view.addSubview(forecastsView)
        forecastsView.snp.makeConstraints { (make) in
            make.leading.equalTo(weatherView.snp.trailing).offset(55)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalTo(weatherView.snp.bottom)
        }
        
        _ = WeatherViewModel.init().todayWeather().subscribe {[weak self] (event) in
            if let entity = event.element{
                self?.weatherView.viewModel = Variable.init(entity)
            }
        }
        
        _ = WeatherViewModel.init().forecast().subscribe({ [weak self] (event) in
            if let entitys = event.element{
                self?.forecastsView.viewModel = Variable.init(entitys)
            }
        })
        
        collectionView.register(CardCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cardCell")
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "baseCell")
        tableView.register(FruitCell.classForCoder(), forCellReuseIdentifier: "fruitCell")
        dataArray = initDataArray()
        self.collectionView.reloadData()
        
        
        dataSource.configureCell = { (dataSource, tableView, IndexPath, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "fruitCell") as! FruitCell
            cell.viewModel = Variable<FruitEntity>(element)
            cell.selectionStyle = .none
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

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150;
    }
}

