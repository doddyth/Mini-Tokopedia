//
//  FilterViewController.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import UIKit
import RangeSeekSlider
import SegueManager
import RxSwift

protocol FilterViewControllerDelegate {
    func filterApplied(withInfo filterInfo: FilterInfo)
}

class FilterViewController: UIViewController, SeguePerformer {
    
    @IBOutlet weak var sliderContainerView: RangeSeekSlider!
    @IBOutlet weak var minimumPriceLabel: UILabel!
    @IBOutlet weak var maximumPriceLabel: UILabel!
    @IBOutlet weak var wholeSaleSwitch: UISwitch!
    @IBOutlet weak var shopTypeBottomWithSelectedTypesConstraint: NSLayoutConstraint!
    @IBOutlet weak var shopTypeBottomWithoutSelectedTypesConstraint: NSLayoutConstraint!
    @IBOutlet weak var shopTypeCollectionView: UICollectionView!
    
    var filterViewModel: FilterViewModel!
    var delegate: FilterViewControllerDelegate?
    var currentFilterInfo: FilterInfo?
    
    var segueManager: SegueManager {
        guard let segueManagerObject = segueManagerObject
            else { return SegueManager(viewController: UIViewController()) }
        return segueManagerObject
    }
    
    fileprivate var segueManagerObject: SegueManager?
    fileprivate let disposeBag = DisposeBag()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueManager.prepare(for: segue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupViewModel()
        
        segueManagerObject = SegueManager(viewController: self)
    }
    
    //MARK: - IBActions
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shopTypeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "openShopTypePage") { [weak self] segue in
            guard let shopTypeViewController: ShopTypeViewController = segue.destination
                as? ShopTypeViewController else { return }
            
            shopTypeViewController.delegate = self
            shopTypeViewController.selectedShopTypes = self?.filterViewModel.currentShopTypes.value
        }
    }
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        let filterInfo = FilterInfo(minPrice: Int32(sliderContainerView.selectedMinValue),
                                    maxPrice: Int32(sliderContainerView.selectedMaxValue),
                                    isWholeSale: wholeSaleSwitch.isOn,
                                    shopTypes: filterViewModel.currentShopTypes.value)
        delegate?.filterApplied(withInfo: filterInfo)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        sliderContainerView.selectedMinValue = sliderContainerView.minValue
        sliderContainerView.selectedMaxValue = sliderContainerView.maxValue
        sliderContainerView.setNeedsLayout()
        minimumPriceLabel.text = (sliderContainerView.selectedMinValue as NSNumber).currencyString()
        maximumPriceLabel.text = (sliderContainerView.selectedMaxValue as NSNumber).currencyString()
        wholeSaleSwitch.isOn = false
        filterViewModel.currentShopTypes.value = [ShopType]()
    }
    
    //MARK: - Private
    
    fileprivate func setupView() {
        shopTypeCollectionView.register(UINib(nibName: "ShopTypeCollectionViewCell", bundle: nil),
                                       forCellWithReuseIdentifier: "ShopTypeCollectionViewCell")
        shopTypeCollectionView.isHidden = true
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12,
                                           bottom: 0, right: 12)
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        layout.itemSize = CGSize(width: 140, height: shopTypeCollectionView.frame.height)
        shopTypeCollectionView.collectionViewLayout = layout
        
        shopTypeBottomWithSelectedTypesConstraint.priority = UILayoutPriority(rawValue: 250)
        shopTypeBottomWithoutSelectedTypesConstraint.priority = UILayoutPriority(rawValue: 999)
        sliderContainerView.delegate = self
        
        guard let filterInfo = currentFilterInfo else { return }
        
        sliderContainerView.selectedMinValue = CGFloat(filterInfo.minPrice)
        sliderContainerView.selectedMaxValue = CGFloat(filterInfo.maxPrice)
        minimumPriceLabel.text = (filterInfo.minPrice as NSNumber).currencyString()
        maximumPriceLabel.text = (filterInfo.maxPrice as NSNumber).currencyString()
        wholeSaleSwitch.isOn = filterInfo.isWholeSale
        filterViewModel.currentShopTypes.value = filterInfo.shopTypes
        
    }
    
    fileprivate func setupViewModel() {
        filterViewModel.currentShopTypes
            .asObservable()
            .bind(to: shopTypeCollectionView.rx.items(
                cellIdentifier: "ShopTypeCollectionViewCell",
                cellType:ShopTypeCollectionViewCell.self)) {
                    (_, shopType: ShopType, cell) in
                    cell.delegate = self
                    cell.shopType = shopType
            }
            .disposed(by: disposeBag)
        
        filterViewModel.currentShopTypes
            .asObservable()
            .subscribe(onNext: { [weak self] shopTypes in
                guard let weakSelf = self else { return }
                
                weakSelf.shopTypeCollectionView.isHidden = shopTypes.count == 0
                weakSelf.shopTypeBottomWithSelectedTypesConstraint.priority = shopTypes.count > 0 ?
                    UILayoutPriority(rawValue: 999) : UILayoutPriority(rawValue: 250)
                weakSelf.shopTypeBottomWithoutSelectedTypesConstraint.priority = shopTypes.count > 0 ?
                    UILayoutPriority(rawValue: 250) : UILayoutPriority(rawValue: 999)
            })
            .disposed(by: disposeBag)
    }
    
}

extension FilterViewController: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        self.minimumPriceLabel.text = (minValue as NSNumber).currencyString()
        self.maximumPriceLabel.text = (maxValue as NSNumber).currencyString()
    }
    
}

extension FilterViewController: ShopTypeViewControllerDelegate {
    
    func shopTypeApplied(selectedShopTypes: [ShopType]) {
        filterViewModel.shopTypeApplied(shopTypes: selectedShopTypes)
    }
    
}

extension FilterViewController: ShopTypeCollectionViewCellDelegate {
    
    func deleteButtonTapped(withShopType shopType: ShopType) {
        filterViewModel.tapDeleteShopType(withShopType: shopType)
    }
    
}
