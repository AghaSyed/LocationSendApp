//
//  LocationManager.swift
//  GoogleMapImplementation
//
//  Created by Macbook Pro on 02/09/2017.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
class LocationManager: NSObject, CLLocationManagerDelegate,  GMSMapViewDelegate{
    // Make it singelton class
    static let shared = LocationManager()
    var currentLocation: CLLocation?
    var locationManager = CLLocationManager   ()
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        startUpdatingLocation()
    }
    func creatLocationMarker(_ mapView: GMSMapView)  {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!)
        marker.map = mapView
        //        marker.icon = icon
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        // print("Tapped the marker name: \(marker.title!)")
        return true
    }
    func setMapBaseLocation(_ mapView: GMSMapView)  {
        // Create a GMSCameraPosition that tells the map to display the coordinate and  zoom level
        let camera = GMSCameraPosition.camera(withLatitude: 30.3753, longitude: 69.3451, zoom: 6.0)
        mapView.camera = camera
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        if let mylocation = mapView.myLocation {
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            currentLocation = userLocation
        }
        locationManager.stopUpdatingLocation()
    }

}
