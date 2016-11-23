//
//  ViewController.swift
//  GoogleMapDemo
//
//  Created by ThuyPH on 11/23/16.
//  Copyright © 2016 themask. All rights reserved.
//

import UIKit
import GoogleMaps

// api_key : AIzaSyD0i7r-lTQloBAjJT9P7NHGS2kSh7mCBqY


class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6)
//        mapView = GMSMapView.map(withFrame:CGRect.zero, camera: camera)
//        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        // The myLocation attribute of the mapView may be null
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        //setup CLLocationManager
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 15)
        
        self.mapView?.animate(to: camera)
        
        //Finally stop updating location otherwise it will come again and again in this delegate
        locationManager.stopUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.

}

