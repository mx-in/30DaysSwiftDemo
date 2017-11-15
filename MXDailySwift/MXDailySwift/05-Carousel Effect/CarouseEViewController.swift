//
//  ViewController.swift
//  MXCarousel Effect
//
//  Created by mx_in on 16/12/14.
//  Copyright © 2016年 mx_in. All rights reserved.
//

import UIKit

class CarouseEViewController: UIViewController {

    @IBOutlet weak var backgroundImgView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var funnys = funny.createFunny()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CarouselEffect"
        
        var img = UIImage(named: "hello")!
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    fileprivate struct StoryBoard {
        static let CellIdentify = "FunnyCell"
    }
    
}

extension CarouseEViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return funnys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: StoryBoard.CellIdentify, for: indexPath) as! funnyCell
        
        cell.funny = funnys[indexPath.row]
        
        return cell
    }
    
    
}
