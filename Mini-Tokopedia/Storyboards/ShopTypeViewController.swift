//
//  ShopTypeViewController.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 02/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import UIKit

protocol ShopTypeViewControllerDelegate {
    func shopTypeApplied(selectedShopTypes: [ShopType])
}

class ShopTypeViewController: UIViewController {
    
    @IBOutlet weak var goldMerchantSelectedImage: UIImageView!
    @IBOutlet weak var officialStoreSelectedImage: UIImageView!
    
    var delegate: ShopTypeViewControllerDelegate?
    var selectedShopTypes: [ShopType]?
    
    fileprivate var goldMerchantSelected: Bool = false
    fileprivate var officialStoreSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //MARK: - IBActions
    
    @IBAction func goldMerchantButtonTapped(_ sender: Any) {
        goldMerchantSelected = !goldMerchantSelected
        
        updateGoldMerchantImage()
    }
    
    @IBAction func officialStoreButtonTapped(_ sender: Any) {
        officialStoreSelected = !officialStoreSelected
        
        updateOfficialStoreImage()
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        goldMerchantSelected = false
        officialStoreSelected = false
        
        updateGoldMerchantImage()
        updateOfficialStoreImage()
    }
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        var selectedShopTypes = [ShopType]()
        if goldMerchantSelected {
            selectedShopTypes.append(.goldMerchant)
        }
        if officialStoreSelected {
            selectedShopTypes.append(.officialStore)
        }
        delegate?.shopTypeApplied(selectedShopTypes: selectedShopTypes)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Private
    
    fileprivate func setupView() {
        guard let selectedShopTypes = selectedShopTypes else { return }
        
        goldMerchantSelected = selectedShopTypes.contains(.goldMerchant)
        officialStoreSelected = selectedShopTypes.contains(.officialStore)
        goldMerchantSelectedImage.image = goldMerchantSelected ?
            UIImage(named: "iconSelected") :
            UIImage(named: "iconUnselected")
        officialStoreSelectedImage.image = officialStoreSelected ?
            UIImage(named: "iconSelected") :
            UIImage(named: "iconUnselected")
    }
    
    fileprivate func updateGoldMerchantImage() {
        UIView.transition(with: goldMerchantSelectedImage,
                          duration: 0.1,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            guard let weakSelf = self else { return }
                            weakSelf.goldMerchantSelectedImage.image = weakSelf.goldMerchantSelected ?
                                UIImage(named: "iconSelected") :
                                UIImage(named: "iconUnselected")
            }, completion: nil)
    }
    
    fileprivate func updateOfficialStoreImage() {
        UIView.transition(with: officialStoreSelectedImage,
                          duration: 0.1,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            guard let weakSelf = self else { return }
                            weakSelf.officialStoreSelectedImage.image = weakSelf.officialStoreSelected ?
                                UIImage(named: "iconSelected") :
                                UIImage(named: "iconUnselected")
            }, completion: nil)
    }
}
