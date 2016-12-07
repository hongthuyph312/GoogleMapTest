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


class ViewController: UIViewController,CLLocationManagerDelegate, UISearchBarDelegate, UINavigationControllerDelegate,GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6)
//        mapView = GMSMapView.map(withFrame:CGRect.zero, camera: camera)
//        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        // The myLocation attribute of the mapView may be null
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        
        //setup CLLocationManager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         view.endEditing(true)
        let apiRequestString = baseURLGeocode + "address=" + searchBar.text!
        let URLString = apiRequestString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlRequest = URL(string: URLString!)
        
        let urlSection = URLSession.shared
        let task = urlSection.dataTask(with: urlRequest!, completionHandler: {(data,response,error) in
             let response = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            if let resultData = response?.data(using: String.Encoding.utf8.rawValue) {
                do {
                    let resultDictionary = try JSONSerialization.jsonObject(with: resultData, options: []) as? [String:AnyObject]
                    print(resultDictionary)
                } catch let error as NSError {
                    print(error)
                }
            }
            print(response)
        })
        task.resume()
    }
    
    
    @IBAction func changeMapType(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "Map Types", message: "Select map type", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let normalMapTypeAction = UIAlertAction(title: "Normal", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            self.mapView.mapType = kGMSTypeNormal
        }
        
        let terrainMapTypeAction = UIAlertAction(title: "Terrain", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            self.mapView.mapType = kGMSTypeTerrain
        }
        
        let hybridMapTypeAction = UIAlertAction(title: "Hybrid", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            self.mapView.mapType = kGMSTypeHybrid
        }
        
        let cancelAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(normalMapTypeAction)
        actionSheet.addAction(terrainMapTypeAction)
        actionSheet.addAction(hybridMapTypeAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.

}

