//
//  ImageScrollerEffectVC.swift
//  DailySwift
//
//  Created by mx_in on 16/12/18.
//  Copyright © 2016年 mx_in. All rights reserved.
//

import UIKit

class ImageScrollerEffectVC: UIViewController, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView = UIImageView(image: UIImage(named: "steve"))
        let imageScale = UIScreen.main.bounds.width/imageView.bounds.width
        
        var imageFrame = imageView.frame
        imageFrame.size.width *= imageScale
        imageFrame.size.height *= imageScale
        imageView.frame = imageFrame
        
        imageView.isUserInteractionEnabled = true
        
        setupScrollView()
        scrollView.delegate = self;
        setZoomScaleFor(scrollView.bounds.size)
        scrollView.zoomScale = scrollView.minimumZoomScale
        
        setImageCenter()
        
        let doubleTapGesutre = UITapGestureRecognizer(target: self, action: #selector(self.zoomToMin))
        doubleTapGesutre.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTapGesutre)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setZoomScaleFor(scrollView.bounds.size)
        
        if scrollView.zoomScale < scrollView.minimumZoomScale {
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
        setImageCenter()
    }
    
    func zoomToMin() {
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView.zoomScale = self.scrollView.minimumZoomScale
            self.setImageCenter()
        })
    }
    
    fileprivate func setZoomScaleFor(_ scrollViewSize: CGSize) {
        let imageSize = imageView.bounds.size
        let widthScale =  scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.maximumZoomScale = 3.0
    }
    
    fileprivate func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
        scrollView.backgroundColor = UIColor.clear
        scrollView.contentSize = imageView.bounds.size
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
    }
    
    fileprivate func setImageCenter() {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.bounds.size
        
        let horizontalSapce = imageSize.width > scrollViewSize.width ? 0 : (scrollViewSize.width - imageSize.width) / 2.0
        let verticalSpace = imageSize.height > scrollViewSize.height ? 0 : (scrollViewSize.height - imageSize.height) / 2.0
        
        scrollView.contentInset = UIEdgeInsetsMake(verticalSpace, horizontalSapce, verticalSpace, horizontalSapce)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.setImageCenter()
    }
    
}
