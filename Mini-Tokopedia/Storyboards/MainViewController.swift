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
import UIScrollView_InfiniteScroll

class MainViewController: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    var mainViewModel: MainViewModel!
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let PADDING_SIZE: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupMainViewModel()
        mainViewModel.didLoad()
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
    }
}
