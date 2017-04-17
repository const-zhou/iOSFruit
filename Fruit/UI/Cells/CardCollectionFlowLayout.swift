//
//  CardCollectionFlowLayout.swift
//  Fruit
//
//  Created by 周敦广 on 2017/3/28.
//  Copyright © 2017年 周敦广. All rights reserved.
//

import Foundation
import UIKit

class CardCollectionFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemWidth:CGFloat = 100.0
    let itemHeight:CGFloat = 100.0
    
    override func prepare() {
        super.prepare()
        self.itemSize = CGSize.init(width: itemWidth, height: itemHeight)
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 100
        let inset = ((self.collectionView?.frame.width)! - itemWidth) / 2.0
        self.sectionInset = UIEdgeInsets.init(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var lastRect:CGRect = CGRect.zero
        lastRect.origin = proposedContentOffset
        lastRect.size = (self.collectionView?.frame.size)!
        
        let array = self.layoutAttributesForElements(in: lastRect)
        let centerX = proposedContentOffset.x + (self.collectionView?.frame.width)! / 2.0
        var adjustOffsetX = CGFloat.greatestFiniteMagnitude
        for attrs in array!{
            if abs(attrs.center.x - centerX) < abs(adjustOffsetX) {
                adjustOffsetX = attrs.center.x - centerX
            }
        }
        return CGPoint.init(x: proposedContentOffset.x + adjustOffsetX, y: proposedContentOffset.y)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visiableRect = CGRect.zero
        visiableRect.size = (self.collectionView?.frame.size)!
        visiableRect.origin = (self.collectionView?.contentOffset)!
        
        let array = super.layoutAttributesForElements(in: rect)
        let centerX = (self.collectionView?.contentOffset.x)! + (self.collectionView?.frame.width)!/2.0
        
        for attrs in array!{
            if !visiableRect.intersects(attrs.frame){
                continue
            }
            let itemCenterX = attrs.center.x
            let a_x = 1.0 - abs(itemCenterX - centerX) * 0.6  / (self.collectionView?.frame.width)!
            let scale = 1.0 + a_x * 0.8
            attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0)
        }
        return array
    }
}
