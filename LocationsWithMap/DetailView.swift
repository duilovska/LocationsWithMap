//
//  DetailView.swift
//  LocationsWithMap
//
//  Created by daria on 16/12/15.
//  Copyright © 2015 daria. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class DetailViewController: UIViewController {
    
    var location:Place? {
        didSet {
            if isViewLoaded() {
                setzeFeatureUndZeigeEsAn(location!)
            }
        }
    }
    
    private func  setzeFeatureUndZeigeEsAn(location:Place) {
        lblName.text = location.name
        lblLat.text = String(location.latitude)
        lblLng.text = String(location.longitude)
    }
    
    
    
    
    var lblName:UILabel!
    var lblLat: UILabel!
    var lblLng:UILabel!
    var btnBack: UIButton!
    var btnSave: UIButton!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.lightGrayColor()
        
        lblName = {
            let v = UILabel()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.contentMode = .Center
            return v
            }()
        
        lblLat = {
            let v = UILabel()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
            }()
        
        lblLng = {
            let v = UILabel()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
            }()
        
        btnBack = {
            let v = UIButton()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.setTitle("Back", forState: .Normal)
            return v
            }()
        
        btnSave = {
            let v = UIButton()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.setTitle("Save", forState: .Normal)
            return v
            }()
        
        // --------------------------------------------------------------------------------
        // view hierarchy
        // --------------------------------------------------------------------------------
        
        view.addSubview(lblName)
        view.addSubview(lblLat)
        view.addSubview(lblLng)
        view.addSubview(btnBack)
        view.addSubview(btnSave)
        
        
        // --------------------------------------------------------------------------------
        // auto layout
        // --------------------------------------------------------------------------------
        
        view.addConstraint(NSLayoutConstraint(item: lblName, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: lblName, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: lblLat, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: lblLat, attribute: .Top, relatedBy: .Equal, toItem: lblName, attribute: .Bottom, multiplier: 1, constant: 10))
        
        view.addConstraint(NSLayoutConstraint(item: lblLng, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: lblLng, attribute: .Top, relatedBy: .Equal, toItem: lblLat, attribute: .Bottom, multiplier: 1, constant: 10))
        
        view.addConstraint(NSLayoutConstraint(item: btnBack, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: -50))
        view.addConstraint(NSLayoutConstraint(item: btnBack, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 20))
        
        view.addConstraint(NSLayoutConstraint(item: btnSave, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: btnSave, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 20))
       
        //---------------------------------------------------------------------------------
        //target
        //---------------------------------------------------------------------------------
        
        btnBack.addTarget(self, action: "btnPressed:", forControlEvents: .TouchUpInside)
        btnSave.addTarget(self, action: "saveToFile:", forControlEvents: .TouchUpInside)
        
        if let l = location {
            setzeFeatureUndZeigeEsAn(l)
        }
    }
    
    func btnPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveToFile(sender: UIButton) {
//        let txt = NSString(string: lblName.text!)
        let path = "/Users/daria/\(lblName.text!).json"
//        let path = "Desktop/Swift_Apprentice_v1.1.pdf"
      
        let place: [String : AnyObject] = ["name" :lblName.text!, "latitude": Double(lblLat.text!)!, "longitude": Double(lblLng.text!)!]
        let json = JSON(place)
        let str = json.description
        let data = str.dataUsingEncoding(NSUTF8StringEncoding)!

        data.writeToFile(path, atomically: true)
//        if let file = NSFileHandle(forWritingAtPath:path) {
//            file.writeData(data)
//        } else {
//            print("geht nicht")
//        }
        
//        do {
//            try txt.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
//        } catch {
//            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
//        }
    }
    
}