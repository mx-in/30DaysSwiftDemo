//
//  AnimationCellModel.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/25.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import Foundation

struct AnimationCellModel {
    let imagePath: String
    
    init(imagePath: String?) {
        self.imagePath = imagePath ?? ""
    }
}
