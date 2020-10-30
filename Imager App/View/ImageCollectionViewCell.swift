//
//  ImageCollectionViewCell.swift
//  Imager App
//
//  Created by Ulvi Bashirov on 10/26/20.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        container.backgroundColor = .systemGray
        container.layer.cornerRadius = 20
        container.layer.masksToBounds = true
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.gray.cgColor
    }
    
    func setUp(photo: Photo) {
        label.text = photo.title
        imageV.contentMode = .center
        imageV.setImage(url: Network.getImage(photo: photo))
    }
}
