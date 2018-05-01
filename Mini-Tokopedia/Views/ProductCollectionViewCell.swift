//
//  ProductCollectionViewCell.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var productViewParam: ProductViewParam? {
        didSet {
            guard let productViewParam = productViewParam else { return }
            
            self.productTitleLabel.text = productViewParam.name
            self.productPriceLabel.text = productViewParam.price
            self.productImage.loadUrl(productViewParam.imageURL)
        }
    }
}
