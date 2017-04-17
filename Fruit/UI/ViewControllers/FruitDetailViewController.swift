//
//  FruitDetailViewController.swift
//  Fruit
//
//  Created by 周敦广 on 2017/4/5.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import UIKit
import StarWars

class FruitDetailViewController:UIViewController{
    lazy var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.frame = CGRect.init(x: 100, y: 100, width: 100, height: 20);
        label.text = "hello world"
        self.view.addSubview(label)
        self.view.backgroundColor = UIColor.white
        self.transitioningDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) { 
            
        }
    }
}

extension FruitDetailViewController:UIViewControllerTransitioningDelegate{
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return StarWarsGLAnimator()
    }
}
