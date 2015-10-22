//
//  NavigationViewController.swift
//  MarkU
//
//  Created by Zhang, Alex on 10/17/15.
//  Copyright © 2015 Zhang, Alex. All rights reserved.
//

import UIKit
import MapKit

class NavigationViewController: UIViewController, MKMapViewDelegate{

    
    @IBOutlet weak var navigationMapView: MKMapView!
    
    var destinationCoordinate: CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationMapView.delegate = self
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: (g_locationCoordinate?.coordinate)!, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate!, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .Automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.navigationMapView.addOverlay(route.polyline)
                self.navigationMapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
        
        let srcPin = MKPointAnnotation()
        srcPin.coordinate = (g_locationCoordinate?.coordinate)!
        srcPin.title = "Your Position"
        navigationMapView.addAnnotation(srcPin)
        
        let dstPin = MKPointAnnotation()
        dstPin.coordinate = destinationCoordinate!
        dstPin.title = "Your Destination"
        navigationMapView.addAnnotation(dstPin)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // route renderer
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blueColor()
        return renderer
    }

    @IBAction func OpenMapsApp(sender: AnyObject) {
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = destinationCoordinate!
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Your Destination"
        mapItem.openInMapsWithLaunchOptions(options)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
