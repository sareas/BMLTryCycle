//
//  ViewController.swift
//  BMLTryCycle
//
//  Created by Mustafa Al-Hayali on 2015-11-17.
//  Copyright © 2015 Mustafa Al-Hayali. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblDetails: UILabel!
    let locationManager = CLLocationManager()
    let station = Station()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self

        self.locationManager.requestWhenInUseAuthorization()

        for pins in station.mapPins {
            guard let myPins = pins as? Annotations else {return }
            mapView.addAnnotation(myPins)
        }
        
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        if (locationManager.location != nil){
            centerMapOnLocation(locationManager.location!)
        }
    }

    let regionRadius :CLLocationDistance = 300
    func centerMapOnLocation(location : CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var pinView : MKAnnotationView?
        var reuseID : String = pinID!
        if reuseID  == "bikePin"{
            var bikePinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as MKAnnotationView!
            if bikePinView == nil {
                bikePinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "bikePin")
                var availableBikesKeysArray = [((bikePinView.annotation?.title)!)!]
                for key in availableBikesKeysArray{
                    if station.parsedAvailableBikes[key] as! Int > 10 {
                        print(station.parsedAvailableBikes[key] as! Int)
                        bikePinView.image = UIImage(named: "bikeicon")
                    }else{
                        bikePinView.image = UIImage(named: "bikeicon1")
                    }
                }
                bikePinView.bounds = CGRectMake(0, 0, 25.0, 25.0)
            } else {
                bikePinView.annotation = annotation
            }
            pinView =  bikePinView
        }else if reuseID == "dockPin" {
            var dockPinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as MKAnnotationView!
            if dockPinView == nil {
                dockPinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "dockPin")
                var availableDocksKeysArray = [((dockPinView.annotation?.title)!)!]
                for key in availableDocksKeysArray{
                    if station.parsedAvailableDocks[key] as! Int > 10 {
                        print(station.parsedAvailableDocks[key] as! Int)
                        dockPinView.image = UIImage(named: "dockicon")
                    }else{
                        dockPinView.image = UIImage(named: "dockicon1")
                    }
                }
                dockPinView.bounds = CGRectMake(0, 0, 25.0, 25.0)
            } else {
                
                dockPinView.annotation = annotation
            }
            pinView =  dockPinView
        }
        return pinView
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        guard let anny = view.annotation else { return }
        guard let title = anny.title else { return }
        guard let subtitle = anny.subtitle else { return }
        lblDetails.text = "\(title!) \(subtitle!)"
    }
}

