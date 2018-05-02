//
//  ShopTypeCollectionViewCell.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 02/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import UIKit

protocol ShopTypeCollectionViewCellDelegate {
    func deleteButtonTapped(withShopType shopType: ShopType)
}

class ShopTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var shopTypeLabel: UILabel!
    @IBOutlet weak var deleteButtonContainerView: UIView!
    
    var delegate: ShopTypeCollectionViewCellDelegate?
    
    var shopType: ShopType? {
        didSet {
            guard let shopType = shopType else { return }
            
            shopTypeLabel.text = shopType.rawValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let shopType = shopType else { return }
        
        delegate?.deleteButtonTapped(withShopType: shopType)
    }
    //MARK: - Private
    
    fileprivate func setupView() {
        containerView.layer.cornerRadius = containerView.frame.height / 2
        containerView.layer.borderColor = UIColor(white: 0, alpha: 0.20).cgColor
        containerView.layer.borderWidth = 1
        
        deleteButtonContainerView.layer.cornerRadius = containerView.frame.height / 2
        deleteButtonContainerView.layer.borderColor = UIColor(white: 0, alpha: 0.20).cgColor
        deleteButtonContainerView.layer.borderWidth = 1
    }

}
