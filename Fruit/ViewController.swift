//
//  ViewController.swift
//  Fruit
//
//  Created by 周敦广 on 2017/3/27.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let flowLayout = CardCollectionFlowLayout.init()
    lazy var collectionView = UICollectionView()
    var dataArray:[String] = []
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        EntityHelper.allFurits { (fruits) -> (Void) in
            if fruits is Array<AnyObject>{
                let fruitInfo = fruits![0] as! [String:AnyObject]
                let fruit = FruitEntity.init(dict: fruitInfo)
                print(fruit.convert2Dictionary())
            }
        }
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
        
        collectionView.register(CardCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cardCell")
        
        dataArray = initDataArray()
        self.collectionView.reloadData()
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

