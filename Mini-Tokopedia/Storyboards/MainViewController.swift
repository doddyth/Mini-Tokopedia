//
//  MainViewController.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Rswift
import UIScrollView_InfiniteScroll
import SegueManager

class MainViewController: UIViewController, SeguePerformer {

    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorBannerView: UIView!
    
    var mainViewModel: MainViewModel!
    var segueManager: SegueManager {
        guard let segueManagerObject = segueManagerObject
            else { return SegueManager(viewController: UIViewController()) }
        return segueManagerObject
    }
    
    fileprivate var segueManagerObject: SegueManager?
    fileprivate let disposeBag = DisposeBag()
    fileprivate let PADDING_SIZE: CGFloat = 8
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueManager.prepare(for: segue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupMainViewModel()
        mainViewModel.didLoad()
        
        segueManagerObject = SegueManager(viewController: self)
    }
    
    //MARK: - IBActions
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "openFilterPage") { [weak self] segue in
            guard let filterViewController: FilterViewController = segue.destination
                as? FilterViewController else { return }
            
            filterViewController.delegate = self
            filterViewController.currentFilterInfo = self?.mainViewModel.currentFilterInfo
        }
    }
    
    @IBAction func retryButtonTapped(_ sender: Any) {
        mainViewModel.tapRetry()
    }
    
    //MARK: - Private
    
    fileprivate func setupCollectionView() {
        productCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil),
                                       forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: PADDING_SIZE, left: PADDING_SIZE,
                                           bottom: PADDING_SIZE, right: PADDING_SIZE)
        layout.minimumInteritemSpacing = 0
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - PADDING_SIZE * 3) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 80)
        productCollectionView.collectionViewLayout = layout
        
        productCollectionView.addInfiniteScroll { [weak self] _ in
            self?.mainViewModel.loadMore()
        }
        
        productCollectionView.setShouldShowInfiniteScrollHandler { [weak self] _ -> Bool in
            guard let weakSelf = self else { return false }
            
            return !weakSelf.mainViewModel.allProductLoaded
        }
    
    }
    
    fileprivate func setupMainViewModel() {
        mainViewModel.productViewParams
            .asObservable()
            .do(onNext: { [weak self] _ in
                self?.productCollectionView.finishInfiniteScroll(completion: nil)
            })
            .bind(to: productCollectionView.rx.items(
                cellIdentifier: "ProductCollectionViewCell",
                cellType:ProductCollectionViewCell.self)) {
                    (_, productViewParam: ProductViewParam, cell) in
                    cell.productViewParam = productViewParam
            }
            .disposed(by: disposeBag)
        
        mainViewModel.loadingShown
            .asDriver()
            .drive(onNext: { [weak self] loadingShown in
                self?.loadingView.isHidden = !loadingShown
            })
        
        mainViewModel.errorShown
            .asDriver()
            .drive(onNext: { [weak self] errorShown in
                self?.errorView.isHidden = !errorShown
            })
        
        mainViewModel.errorBannerShown
            .asDriver()
            .drive(onNext: { [weak self] errorShown in
                guard let weakSelf = self else { return }
                if errorShown {
                    weakSelf.productCollectionView.finishInfiniteScroll(completion: nil)
                    weakSelf.animateShowAndHideErrorBanner()
                } else {
                    weakSelf.errorBannerView.isHidden = true
                }
            })
    }
    
    fileprivate func animateShowAndHideErrorBanner() {
        errorBannerView.isHidden = false
        errorBannerView.alpha = 1
        UIView.animate(withDuration: 0.5,
                       delay: 2,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
                        self?.errorBannerView.alpha = 0
            }, completion: { [weak self] _ in
                self?.errorBannerView.isHidden = true
        })
    }
}

extension MainViewController: FilterViewControllerDelegate {
    
    func filterApplied(withInfo filterInfo: FilterInfo) {
        mainViewModel.filterApplied(withInfo: filterInfo)
    }
    
}
