//
//  FlickrViewModel.swift
//  Imager App
//
//  Created by Ulvi Bashirov on 10/26/20.
//

import Foundation
import UIKit

class FlickrViewModel {
    var photos = [Photo]()
    
    func setPhotos(page: Int, completion: @escaping () -> ()) {
        Network.getImagesArray(page: page) { result in
            if let images = result.photos?.photo {
                self.photos.append(contentsOf: images)
                completion()
            }
        }
    }
    
    func sizeOfImageAt(url: URL) -> CGSize? {
        // with CGImageSource we avoid loading the whole image into memory
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            return nil
        }
        
        let propertiesOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions) as? [CFString: Any] else {
            return nil
        }
        
        if let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
           let height = properties[kCGImagePropertyPixelHeight] as? CGFloat {
            return CGSize(width: width, height: height)
        } else {
            return nil
        }
    }
}
