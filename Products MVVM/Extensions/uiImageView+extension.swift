//
//  uiImageView+extension.swift
//  Products MVVM
//
//  Created by Prashantdan on 27/01/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlstring: String) {
        guard let url = URL.init(string: urlstring) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlstring)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
