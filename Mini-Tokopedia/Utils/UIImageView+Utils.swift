//
//  UIImageView+Utils.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func loadUrl(_ url: String,
                 placeholder: UIImage? = PlaceholderImage.get(),
                 completion: (() -> Void)? = nil) {
        guard let url = URL(string: url) else { return }
        kf.setImage(with: url,
                    placeholder: placeholder,
                    options: [.transition(ImageTransition.fade(0.5))]) { _, error, _, _ -> Void in
                        guard let completion = completion , error == nil else { return }
                        completion()
        }
    }
    
}
