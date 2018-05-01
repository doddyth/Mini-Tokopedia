//
//  ViewUtils.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import UIKit

class PlaceholderImage {
    
    static var image: UIImage?
    
    class func get() -> UIImage {
        if image == nil {
            let color = UIColor(red: (230/255), green: (230/255), blue: (230/255), alpha: 1)
            let size = CGSize(width: 1, height: 1)
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            color.setFill()
            UIRectFill(rect)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return image!
    }
    
}
