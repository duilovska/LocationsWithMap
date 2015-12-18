//
//  AppDelegate.swift
//  LocationsWithMap
//
//  Created by daria on 12/12/15.
//  Copyright © 2015 daria. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        window!.rootViewController = ViewController()
//        window!.makeKeyAndVisible()

        
        if let path = NSBundle.mainBundle().pathForResource("com.fredd.starmap", ofType: "plist") {
            if let myDict = NSDictionary(contentsOfFile: path) {
                let ulArray = myDict["UserLocations"] as! NSArray
                var locationsArray: [Place] = []
                
                for element in ulArray {
                    let dict = element as! NSDictionary
                    let name = dict["locationName"]!
                    let lat = dict["latitude"]!
                    let lng = dict["longitude"]!
                    let location = Place(name: name as! String, lat: lat as! Double, lng: lng as! Double)
                    locationsArray.append(location)
                    
                }
                let myViewController = window!.rootViewController as! ViewController

//                print("\(window!.rootViewController!)")
//                let rvc:UIViewController? = window!.rootViewController
//                let myViewController:Betty
//                myViewController = Betty()
//            
//                window!.rootViewController = myViewController
                
//                print("\(myViewController)")
                
                myViewController.location = locationsArray
            }
        }
        
        return true
    }
    
}

