//
//  WikiFaceViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/6.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class WikiFaceViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var faceImageView: UIImageView!
    
    let faceImageSize = CGSize(width: 300, height: 400)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        self.faceImageView.alpha = 0.0
        self.faceImageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
    }
    
    func faceImageAnimate() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: { () -> Void in
            
            self.faceImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.faceImageView.alpha = 1
            
            self.faceImageView.layer.shadowOpacity = 0.4
            self.faceImageView.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
            self.faceImageView.layer.shadowRadius = 15.0
            self.faceImageView.layer.shadowColor = UIColor.black.cgColor
            
        }, completion: nil )
        
    }
}

extension WikiFaceViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let name = textField.text {
            nameTextField.resignFirstResponder()
            return setupFaceImage(withName: name)
        }
        return false
    }
    
    func setupFaceImage(withName name: String) -> Bool {
        
        let wikiFace = WikiFace()
        do {
            try wikiFace.faceForPerson(name, size: faceImageSize) { image, isImageFound in
                
                DispatchQueue.main.async {
                    if isImageFound == true {
                        self.faceImageView.image = image
                        self.faceImageAnimate()
                        WikiFace.centerImageViewOnFace(self.faceImageView)
                    }
                }

            }
            
        } catch WikiFace.WikiFaceError.couldNotDownloadImage {
            print("could not downloading an image from wikipeida")
        } catch {
            print(error)
        }
        
        return true
    }
}
