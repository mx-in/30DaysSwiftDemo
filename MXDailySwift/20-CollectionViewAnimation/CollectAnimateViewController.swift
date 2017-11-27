//
//  CollectAnimateViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/25.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

extension Array {
    func safeIndex(_ i: Int) -> Element? {
        return i < self.count && i >= 0 ? self[i] : nil
    }
}

class CollectAnimateViewController: UICollectionViewController {

    private struct Storyboard {
        static let CellIdentifier = String(describing: AnimationCollectionViewCell.self)
        static let NibName = String(describing: AnimationCollectionViewCell.self)
    }
    
    private struct Constants {
        static let AnimationDuration = 0.5
        static let AnimationDelay = 0.0
        static let AnimationSpringDamping: CGFloat = 1.0
        static let AnimationInitialSpringVelocity: CGFloat = 1.0
    }
    
    var imageCollection: AnimationImageCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollection = AnimationImageCollection()

        collectionView?.register(UINib(nibName: Storyboard.NibName, bundle: nil), forCellWithReuseIdentifier: Storyboard.CellIdentifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        collectionView?.reloadData()
    }
    
    func handleAnimationCellSelected(_ collectionView: UICollectionView, cell: AnimationCollectionViewCell) {
        cell.handleCellSelected()
        cell.backButtonTapped = self.backButtonDidTouch
        
        let animation: () -> () = {
            cell.frame = collectionView.bounds
        }
        
        let completion: (Bool) -> () = { _ in
            collectionView.isScrollEnabled = false
        }
        
        UIView.animate(withDuration: Constants.AnimationDuration,
                       delay: Constants.AnimationDelay,
                       usingSpringWithDamping: Constants.AnimationSpringDamping,
                       initialSpringVelocity: Constants.AnimationInitialSpringVelocity,
                       options: [],
                       animations: animation,
                       completion: completion)
    }
    
    func backButtonDidTouch() {
        guard let indexPaths = self.collectionView?.indexPathsForSelectedItems else {
            return
        }
        
        collectionView?.isScrollEnabled = true
        collectionView?.reloadItems(at: indexPaths)
    }
    
}

extension CollectAnimateViewController {
    
    //    MARK:- CollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection?.images.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as? AnimationCollectionViewCell, let cellModel = imageCollection?.images.safeIndex(indexPath.row) else {
            return UICollectionViewCell()
        }
        
        cell.prepareCell(cellModel)
        return cell
    }
    
    //  MARK:- CollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnimationCollectionViewCell else {
            return
        }
        
        self.handleAnimationCellSelected(collectionView, cell: cell)
    }
}
