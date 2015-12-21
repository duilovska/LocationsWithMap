//
//  Pin.swift
//  LocationsWithMap
//
//  Created by daria on 12/12/15.
//  Copyright © 2015 daria. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class Pin : NSObject, MKAnnotation {
    var place: Place
	
    //🔵 init
	
	init(place:Place) {
		self.place = place
	}
	
    // 🔵 protocol MKAnnotation
    
    var coordinate:CLLocationCoordinate2D {
		get {
			return CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
		}
    }
	
    // 🔵 protocol Printable
    
    override var description: String {
        return "<SimpleAnnotation: \(coordinate)>"
    }
    
    var subtitle:String? {
        return ""
    }
    
    var title:String? {
        return place.name
    }

}
