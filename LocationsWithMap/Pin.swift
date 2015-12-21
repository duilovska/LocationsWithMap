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
    var place: Place?
	
    //🔵 init
	
	init(place:Place) {
		self.place = place
		_coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
		_title = place.name
		_subtitle = ""
	}
	
    // 🔵 protocol MKAnnotation
    
    var _coordinate:CLLocationCoordinate2D
    var coordinate:CLLocationCoordinate2D {
        get {
            return _coordinate
        }
    }
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        _coordinate = newCoordinate
    }
    
    // 🔵 protocol Printable
    
    override var description: String {
        return "<SimpleAnnotation: \(coordinate)>"
    }
    
    var _subtitle:String?
    var subtitle:String? {
        return _subtitle ?? ""
    }
    
    var _title:String?
    var title:String? {
        return _title ?? "Simple"
    }
    


}
