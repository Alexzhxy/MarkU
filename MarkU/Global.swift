//
//  Global.swift
//  MarkU
//
//  Created by Zhang, Alex on 10/14/15.
//  Copyright © 2015 Zhang, Alex. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

var g_locationCoordinate: CLLocation? = nil // share current location
var g_favoriteItems = [NSManagedObject]()   // saved favorite places
let g_locationManager = CLLocationManager() // location manager


