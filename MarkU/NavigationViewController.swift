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
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2DMake(37, -122), addressDictionary: nil))
        //request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate!, addressDictionary: nil))
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
        srcPin.coordinate = CLLocationCoordinate2DMake(37, -122)
        //srcPin.coordinate = (g_locationCoordinate?.coordinate)!
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
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blueColor()
        return renderer
    }

    @IBAction func OpenMapsApp(sender: AnyObject) {
        var latitute:CLLocationDegrees =  37
        var longitute:CLLocationDegrees =  -122
        
        let regionDistance:CLLocationDistance = 10000
        var coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        var options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        var placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        var mapItem = MKMapItem(placemark: placemark)
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
