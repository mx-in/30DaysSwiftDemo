//
//  AnimationCollectionView.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/25.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

struct AnimationImageCollection {
    private let imagePaths = ["1", "2", "3", "4", "5"]
    var images: [AnimationCellModel]
    
    init() {
        images = imagePaths.map {
            AnimationCellModel(imagePath: "20-\($0)")
        }
    }
}

