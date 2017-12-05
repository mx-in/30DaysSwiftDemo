
//
//  SignupProfileViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/5.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit
import Photos

class SignupProfileViewController: UIViewController {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    
    private var profileImage: UIImage!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true;
        userNameTextField.becomeFirstResponder()
        userProfileImageView.layer.cornerRadius = userProfileImageView.bounds.width / 2
        userProfileImageView.layer.masksToBounds = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func pickProfileImage(_ sender: UITapGestureRecognizer) {
        let authorization = PHPhotoLibrary.authorizationStatus()

        if authorization == .notDetermined {
            PHPhotoLibrary.requestAuthorization({ status in
                DispatchQueue.main.async(execute: {
                    self.pickProfileImage(sender)
                })
            })
        }
        
        if authorization == .authorized {
            let controller = ImagePickerSheetController()
            controller.addAction(ImageAction(title: NSLocalizedString("Take Photo or Video", comment: "Action Title"), secondaryTitle: NSLocalizedString("Use this one", comment: "Action Title"), handler: { _ in
                self.presentCamera()
            }, secondaryHandler: { (action, photoCount) in
                controller.getSelectedImagesWithCompletion({ images in
                    self.profileImage = images[0]
                    self.userProfileImageView.image = self.profileImage
                })
            }))
            
            controller.addAction(ImageAction(title: NSLocalizedString("Cancel", comment: "Action Title"), style: .cancel, handler: nil, secondaryHandler: nil))
            
            present(controller, animated: true, completion: nil)
        }

    }
    
    func presentCamera() {
        
    }
    
    @IBAction func backBtnDidClick(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
