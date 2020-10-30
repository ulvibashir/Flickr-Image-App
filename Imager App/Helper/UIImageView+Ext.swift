//
//  UIImageView+Ext.swift
//  Imager App
//
//  Created by Ulvi Bashirov on 10/29/20.
//

import UIKit
import SDWebImage
import Foundation

extension UIImageView {
    
    func setImage(url: String?) {
        sd_setImage(with: URL(string: url ?? ""))
    }
}
