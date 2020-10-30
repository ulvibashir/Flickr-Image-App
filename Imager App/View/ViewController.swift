//
//  ViewController.swift
//  Imager App
//
//  Created by Ulvi Bashirov on 10/26/20.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var flickrCollectionView: UICollectionView!

    var activity: UIActivityIndicatorView {
        let activity = UIActivityIndicatorView()
        activity.frame = view.bounds
//        view.addSubview(activity)
        return activity
    }
    
    var indexPaths: [IndexPath] = []
    let viewModel = FlickrViewModel()
    var pageCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        layoutSetup()
        activity.startAnimating()
        nextPage()
    }
    
    func layoutSetup() {
        if let layout = flickrCollectionView.collectionViewLayout as? FlickrLayout {
            layout.delegate = self
        }
    }

    func setUp() {
        flickrCollectionView.delegate = self
        flickrCollectionView.dataSource = self
    }
    
    func nextPage() {
        viewModel.setPhotos(page: pageCount) {
            DispatchQueue.main.async {
                self.activity.stopAnimating()
                self.pageCount += 1
                
                self.flickrCollectionView.performBatchUpdates ({
                    for i in self.viewModel.photos.count-15..<self.viewModel.photos.count {
                        self.indexPaths.append(IndexPath(item: i, section: 0))
                    }
                    self.flickrCollectionView.insertItems(at: self.indexPaths)
                    self.flickrCollectionView.reloadData()
                }, completion: nil)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = flickrCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        cell.setUp(photo: viewModel.photos[indexPath.row])
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.photos.count - 1 || indexPath.row == viewModel.photos.count {
            nextPage()
        }
    }
}

extension ViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        let size = viewModel.sizeOfImageAt(url: URL(string: Network.getImage(photo: viewModel.photos[indexPath.row]))!)

        return size!.height
    }
}
