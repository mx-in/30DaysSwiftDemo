//
//  AnimationCollectionViewCell.swift
//  DailySwift
//
//  Created by mx_in on 2017/11/27.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class AnimationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var animationTextView: UITextView!
    @IBOutlet weak var animationImageView: UIImageView!
    
    var backButtonTapped: (() -> Void)?
    
    func prepareCell(_ viewModel: AnimationCellModel) {
        animationImageView.image = UIImage(named: viewModel.imagePath)
        animationTextView.isScrollEnabled = false
        backButton.isHidden = true
        addTapEventHandler()
    }
    
    func handleCellSelected() {
        animationTextView.isScrollEnabled = false
        backButton.isHidden = false
        self.superview?.bringSubview(toFront: self)
    }
    
    private func addTapEventHandler() {
        backButton.addTarget(self, action: #selector(backButtonDidTouch(_:)), for: .touchUpInside)
    }
    
    @objc func backButtonDidTouch(_ sender: UIGestureRecognizer) {
        backButtonTapped?()
    }
    

}
