//
//  ViewController.swift
//  GoogleMapImplementation
//
//  Created by Syed Hasnain on 31/08/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit
import GoogleMaps
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate { 
    // Outlets
    @IBOutlet weak var startingView: UIView!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var myMapView: GMSMapView!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    // User Define Variables
    var isLocationButtonPressed = false
    var emailData: EMail!
    var isEmailSend = false
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.setMapBaseLocation(myMapView)
        LocationManager.shared.initializeTheLocationManager()
        giftImageView.loadGif(name: "giphy")
        setButtonCornerRadius()
        self.emailServiceCheck()
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        print("sned")
        if isEmailSend == true {
            AlertViewController.showEmailsendAlert(self)
            isEmailSend = false
        }
    }
    // OutLet Functions
    @IBAction func didTapGetStartButton(_ sender: Any) {
        startingView.alpha = 0
    }
    @IBAction func didTapShareButton(_ sender: UIButton) {
        if isLocationButtonPressed == true {
            AlertViewController.showCameraOpenAlert(self, completion: { (value) in
                if value == 0 {
                    self.openCameraToTakePicture()
                    print("Camera Open")
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        } else {
            AlertViewController.showLocationButtonErrorAlert(self)
        }
    }
    @IBAction func didTapCurrentLocationButton(_ sender: UIButton) {
        if let location = LocationManager.shared.currentLocation {
            isLocationButtonPressed = true
            self.myMapView.animate(toLocation: location.coordinate)
            LocationManager.shared.creatLocationMarker(myMapView)
            print("User Location : \(location)")
        }else {
            isLocationButtonPressed = false
            LocationManager.shared.startUpdatingLocation()
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // Invoke Show Email Controller
            sendEmai(selectedImage: pickedImage)
        }else {
         AlertViewController.showImagePickerErrorAlert(self)
        }
    }
    func openCameraToTakePicture()  {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func setButtonCornerRadius() {
        currentLocationButton.layer.cornerRadius = 7
        shareButton.layer.cornerRadius = 7
    }
}
