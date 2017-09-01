//
//  ViewController.swift
//  GoogleMapImplementation
//
//  Created by Rashdan Natiq on 31/08/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit
import GoogleMaps
import  CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate { //
    
    @IBOutlet weak var myMapView: GMSMapView!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    var currentLocation: CLLocation?
    var isButtonPressed = false
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setMapBaseLocation()
        // User Location
        initializeTheLocationManager()
        self.setButtonAlphaValue()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // OutLet Functions
    @IBAction func didTapShareButton(_ sender: UIButton) {
     //   sendEmai()
    takeAPhoto()
    }
    @IBAction func didTapCurrentLocationButton(_ sender: UIButton) {
        switchButtonAlphaValue()
        if let location = self.currentLocation {
            isButtonPressed = false
            self.myMapView.animate(toLocation: location.coordinate)
            creatLocationMarker()
            print("User Location : \(location)")
        }else {
            isButtonPressed = true
            self.locationManager.startUpdatingLocation()
        }
    }
    // User Define Functions
    func setButtonAlphaValue() {
        currentLocationButton.alpha = 1
        shareButton.alpha = 0
    }
    func switchButtonAlphaValue() {
        currentLocationButton.alpha = 0
        shareButton.alpha = 1
    }
    func setMapBaseLocation()  {
        // Create a GMSCameraPosition that tells the map to display the coordinate and  zoom level
        let camera = GMSCameraPosition.camera(withLatitude: 30.3753, longitude: 69.3451, zoom: 6.0)
        myMapView.camera = camera
        myMapView.delegate = self
        myMapView.isMyLocationEnabled = true
        if let mylocation = myMapView.myLocation {
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
       // print("Tapped the marker name: \(marker.title!)")
        return true
    }
    func creatLocationMarker()  {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!)
        marker.map = myMapView
        //        marker.icon = icon
    }
    func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
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
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            self.currentLocation = userLocation
        }
        if self.isButtonPressed {
            didTapCurrentLocationButton(currentLocationButton)
        }
        locationManager.stopUpdatingLocation()
    }
    func takeAPhoto()  {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}
