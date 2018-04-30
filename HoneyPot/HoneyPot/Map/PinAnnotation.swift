//
//  PinAnnotation.swift
//  HoneyPot
//
//  Created by Shawn Miller on 4/29/18.
//  Copyright © 2018 HoneyPot. All rights reserved.
//

import Foundation
import MapKit

class PinAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var logFile: String?
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, logFile: String) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.logFile = logFile
    }
}
