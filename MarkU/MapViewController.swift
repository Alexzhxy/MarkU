//
//  MapViewController.swift
//  MarkU
//
//  Created by Zhang, Alex on 9/19/15.
//  Copyright © 2015 Zhang, Alex. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        g_locationManager.delegate = self
        g_locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        g_locationManager.requestWhenInUseAuthorization()
        g_locationManager.requestLocation()
    }
    
    override func viewWillAppear(animated: Bool){
        g_locationManager.requestLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location:CLLocation = locations[locations.count-1]
        g_locationCoordinate = location
        
        if (location.horizontalAccuracy > 0) {
            
            let locationCoordinate: CLLocationCoordinate2D? = location.coordinate
            
            let coordinateRegion = MKCoordinateRegion(center: locationCoordinate!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(coordinateRegion, animated: true)
            
            mapView.removeAnnotations(mapView.annotations)
            let dropPin = MKPointAnnotation()
            dropPin.coordinate = locationCoordinate!
            dropPin.title = "Your Position"
            mapView.addAnnotation(dropPin)
        }
        g_locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error finding location: \(error.localizedDescription)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
