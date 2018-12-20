//
//  UpcomingMoviesLayout.swift
//  TMDB
//
//  Created by André Cocuroci on 21/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import UIKit

class UpcomingMoviesLayout: UICollectionViewLayout {
    private let columns = 2
    private let padding: CGFloat = 6
    private let posterHeight: CGFloat = 250
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let `collectionView` = collectionView else {
            return 0
        }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override func prepare() {
        guard self.cache.isEmpty, let `collectionView` = self.collectionView else {
            return
        }
        
        let columnWidth = self.contentWidth / CGFloat(self.columns)
        var xOffset = [CGFloat]()
        for column in 0 ..< self.columns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: self.columns)
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let height = (self.padding * 2) + self.posterHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: self.padding, dy: self.padding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            self.cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (columns - 1) ? (column + 1) : 0
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in self.cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cache[indexPath.item]
    }
}
