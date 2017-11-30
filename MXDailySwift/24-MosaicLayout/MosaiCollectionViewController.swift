//
//  MosaiCollectionViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/29.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit


class MosaiCollectionViewController: UICollectionViewController {


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate struct Constants {
        static let reuseIdentifier = "Cell"
        static let imageArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21"]
    }
    
    let mosaicLayout = FMMosaicLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.collectionViewLayout = mosaicLayout
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = randomColor()
        cell.alpha = 0
        
        let imageView = cell.viewWithTag(2) as! UIImageView
        imageView.image = UIImage(named: Constants.imageArray[indexPath.row])
        
        let cellDelay = UInt64((arc4random() % 600 / 1000))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(cellDelay)) {
            UIView.animate(withDuration: 0.8) {
                cell.alpha = 1.0
            }
        }

        return cell
    }
    
}

extension MosaiCollectionViewController: FMMosaicLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, interitemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, mosaicCellSizeForItemAt indexPath: IndexPath!) -> FMMosaicCellSize {
        return indexPath.item % 7 == 0 ? .big : .small
    }

}

extension MosaiCollectionViewController {
    fileprivate func randomColor() -> UIColor {
        let randomRed = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomBlue = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
