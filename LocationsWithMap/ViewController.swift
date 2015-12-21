//
//  ViewController.swift
//  LocationsWithMap
//
//  Created by daria on 12/12/15.
//  Copyright © 2015 daria. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class ViewController: UIViewController, MKMapViewDelegate {
    
    //    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    //        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //    }
    
    
    // 🔵 properties
    
    var location:[Place] = []
    var mapView: MKMapView!
    var btnSaveAll: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MKMapView()
        mapView.delegate = self
        mapView.mapType = .Standard
        mapView.frame = view.frame
        view.addSubview(mapView)
        mapView.delegate = self
        for element in location{
            let myPlace = Place(name: element.name, lat: element.latitude, lng: element.longitude)
            let myPin = pinFromPlace(myPlace)
            mapView.addAnnotation(myPin)
        }
        
        btnSaveAll = {
            let v = UIButton()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.setTitle(" Save all pins ", forState: .Normal)
            v.setTitleColor(UIColor.blackColor(), forState: .Normal)
            v.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
            v.backgroundColor = UIColor.lightGrayColor()
            
            return v
            }()
        
        // 🔵 view hierarchy
        
        view.addSubview(btnSaveAll)
        
        // 🔵 auto layout
        
        view.addConstraint(NSLayoutConstraint(item: btnSaveAll, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .Right, relatedBy: .Equal, toItem: btnSaveAll, attribute: .Right, multiplier: 1, constant: 0))
        
        // 🔵 target
        
        btnSaveAll.addTarget(self, action: "saveAllPins:", forControlEvents: .TouchUpInside)
//        btnSaveAll.addTarget(self, action: "\(String(NSUserName())):", forControlEvents: .TouchUpInside)

        
    }
    
    // 🔵 helper
    
    func pinFromPlace(place:Place) -> Pin {
        return Pin(coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), title: place.name, subtitle: "")
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Pin"
        
        if annotation.isKindOfClass(Pin.self) {
            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) {
                annotationView.annotation = annotation
                return annotationView
            } else {
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView.enabled = true
                annotationView.canShowCallout = true
                let btn = UIButton(type: .DetailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                btn.addTarget(self, action: "detailViewAction:", forControlEvents: .TouchUpInside)
                return annotationView
            }
        }
        
        return nil
    }
    
    
    
    //    func
    func detailViewAction(sender: UIButton) {
        if let pin = mapView.selectedAnnotations.first as?  Pin {
            let dvc = DetailViewController()
            
            let name = pin.title
            let lat = pin.coordinate.latitude
            let lng = pin.coordinate.longitude
            let loc = Place(name: name!, lat: lat, lng: lng)
            dvc.location = loc
//            print("detailviewaction \(dvc.location!)")
            presentViewController(dvc, animated: true, completion: {
                //   print("111\(self.dvc.location!)")
                
            })
        }
        
    }
    
    func saveAllPins(sender: UIButton) {
        print("!")
        print(NSUserName())

		let hostHome = NSProcessInfo.processInfo().environment["SIMULATOR_HOST_HOME"]!
		let basePath = (hostHome as NSString).stringByAppendingPathComponent("/Documents/locations/")
		try! NSFileManager.defaultManager().createDirectoryAtPath(basePath, withIntermediateDirectories: true, attributes: nil)
		
        for element in location{
//            let dirPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DesktopDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            let fileNameWithoutWhiteSpaces = element.name.stringByReplacingOccurrencesOfString(" ", withString: "")
            let fileName1 = fileNameWithoutWhiteSpaces.stringByReplacingOccurrencesOfString(")", withString: "")
            let fileName = fileName1.stringByReplacingOccurrencesOfString("Auto(", withString: "")
//            print(dirPaths)
//            let folder = dirPaths[0] as NSString
//            let path = folder.stringByAppendingPathComponent("myfile.txt")
			let hostHome = NSProcessInfo.processInfo().environment["SIMULATOR_HOST_HOME"]!
            let path = hostHome + "/Documents/locations/\(fileName).json"
            let place: [String : AnyObject] = ["name" :element.name, "latitude": Double(element.latitude), "longitude": Double(element.longitude)]
            let json = JSON(place)
            let str = json.description
            let data = str.dataUsingEncoding(NSUTF8StringEncoding)!
            data.writeToFile(path, atomically: true)
            
        }
    }
    
}

