//
//  Places.swift
//  LocationsWithMap
//
//  Created by daria on 12/12/15.
//  Copyright © 2015 daria. All rights reserved.
//

import Foundation
import UIKit

struct Place {
    let name: String
    let latitude: Double
    let longitude: Double
    
    init(name:String, lat:Double, lng:Double) {
        self.name = name
        latitude = lat
        longitude = lng
    }
}