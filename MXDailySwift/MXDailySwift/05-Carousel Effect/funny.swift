//
//  funny.swift
//  MXCarousel Effect
//
//  Created by mx_in on 16/12/14.
//  Copyright © 2016年 mx_in. All rights reserved.
//

import UIKit

class funny {

    var title = " "
    var description = " "
    var numberOfMembers = 0
    var numberOfPost = 0
    var featuredImage: UIImage!
    
    init(title: String, description: String, featuredImage: UIImage) {
        self.title = title
        self.description = description
        self.featuredImage = featuredImage
        numberOfMembers = 1
        numberOfPost = 1
    }
    
    static func createFunny() -> [funny] {
        return [
            funny(title: "Hello there, i miss u.", description: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "hello")!),
            funny(title: "🐳🐳🐳🐳🐳", description: "We love romantic stories. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "dudu")!),
            funny(title: "Training like this, #bodyline", description: "Create beautiful apps. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "bodyline")!),
            funny(title: "I'm hungry, indeed.", description: "Cars and aircrafts and boats and sky. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "wave")!),
            funny(title: "Dark Varder, #emoji", description: "Meet life with full presence. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "darkvarder")!),
            funny(title: "I have no idea, bitch", description: "Get up to date with breaking-news. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "hhhhh")!),
        
        ]
    }
    
    
}
