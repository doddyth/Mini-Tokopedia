//
//  SwinjectStoryboard+Setup.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    
    @objc class func setup() {
        registerStoryboards()
        registerViewModels()
        registerInteractors()
        registerAdapters()
    }
    
    class func resolveDefault<Service>(_ service: Service.Type) -> Service? {
        return SwinjectStoryboard.defaultContainer.resolve(service)
    }
    
    //MARK: - Private
    
    private class func registerStoryboards() {
        defaultContainer.storyboardInitCompleted(MainViewController.self) { r, c in
            c.mainViewModel = r.resolve(MainViewModel.self)!
        }
    }
    
    private class func registerViewModels() {
        defaultContainer.register(MainViewModel.self) { r in
            MainViewModel(displaySearchResult: r.resolve(DisplaySearchResultProtocol.self)!)
        }
    }
    
    private class func registerInteractors() {
        defaultContainer.register(DisplaySearchResultProtocol.self) { r in
            DisplaySearchResult(productApiService: r.resolve(ProductApiServiceProtocol.self)!)
        }
    }
    
    private class func registerAdapters() {
        defaultContainer.register(ProductApiServiceProtocol.self) { r in
            ProductApiService(apiClient: r.resolve(ApiClientProtocol.self)!)
        }
        
        defaultContainer.register(ApiClientProtocol.self) { _ in
            ApiClient()
        }
    }
    
}
