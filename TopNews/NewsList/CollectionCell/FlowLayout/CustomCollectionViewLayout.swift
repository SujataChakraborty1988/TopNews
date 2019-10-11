//
//  flow.swift
//  TopNews
//
//  Created by Sujata Chakraborty on 11/10/2019.
//  Copyright © 2019 Sujata Chakraborty. All rights reserved.
//

import Foundation
import UIKit



class CustomCollectionViewLayout : UICollectionViewFlowLayout{
    
    private var cache : [UICollectionViewLayoutAttributes] = []
    
    private var contentWidth : CGFloat{
        guard let collectionView = collectionView else{
            return 0
        }
        return collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
    }
    
    private var contentHeight : CGFloat = 0
    
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: contentWidth, height: contentHeight)
    }
}

// MARK: - Prepare
extension CustomCollectionViewLayout {
    
    override func prepare() {
        
        guard let collectionView = collectionView else{
            return
        }
        
        cache.removeAll()
        
        var yOrigin : CGFloat = collectionView.contentInset.top
        var xOrigin : CGFloat = collectionView.contentInset.left
        
        var coulumCount = Constants.kLandscapeCoulumnNumber
        
        
        if UIDevice.current.orientation.isPortrait
        {
            coulumCount = Constants.kPortraitCoulumnNumber
        }
        let offset = CGFloat(Int(self.minimumInteritemSpacing) * (coulumCount - 1))
        
        
        let width = (contentWidth - offset) / CGFloat(coulumCount)
        
        
        
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            
            let indexPath = IndexPath(item: item, section: 0)
            
            var itemSize = CGSize(width: width , height: heightOfCellWith(width: width))
            
            if indexPath.item == 0 || indexPath.item % Constants.kHightLightnewsItemInterval == 0
            {
                itemSize = CGSize(width: contentWidth, height: heightOfCellWith(width: contentWidth))
            }
            
            
            let frame = CGRect(x: xOrigin, y: yOrigin, width: itemSize.width, height: itemSize.height)
            
            if xOrigin + itemSize.width + collectionView.contentInset.right > contentWidth{
                
                
                xOrigin = self.collectionView?.contentInset.left ?? CGFloat(Constants.kDefaultPixelValue)
                yOrigin += itemSize.height + self.minimumLineSpacing
            }
            else
            {
                xOrigin += itemSize.width + self.minimumInteritemSpacing
                
            }
            
            
            
            let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
            attributes.frame = frame
            
            cache.append(attributes)
            
            contentHeight = max(contentHeight, yOrigin + itemSize.height)
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let itemAttributes = cache.filter {
            $0.frame.intersects(rect)
        }
        
        return  itemAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first {
            $0.indexPath == indexPath
        }
    }
    
    
    //Size Calculation
    
    func heightOfCellWith(width : CGFloat) -> CGFloat
    {
        let expectedImageWidth = width * CGFloat(Constants.kHeighWidthRatio)
        return expectedImageWidth + CGFloat(Constants.kExpectedWidthKeptForText) + CGFloat(Constants.kBufferHeight)
    }
    
}
