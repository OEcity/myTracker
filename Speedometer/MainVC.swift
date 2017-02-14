//
//  ViewController.swift
//  Speedometer
//
//  Created by Tom Odler on 19.01.17.
//  Copyright © 2017 Tom. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MainVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var manager:CLLocationManager? = nil
    var shouldTrack = false
    var coordsArray = NSMutableArray()
    
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.manager = CLLocationManager.init()
        self.manager?.delegate = self
        self.manager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.manager?.distanceFilter = kCLDistanceFilterNone
        self.manager?.requestAlwaysAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            self.manager?.startUpdatingLocation()
        }
        
        mapView.showsUserLocation = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.title = Bundle.main.infoDictionary!["CFBundleName"] as? String
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        var coordRegion = MKCoordinateRegion()
        coordRegion.center = userLocation.coordinate
        coordRegion.span.latitudeDelta = 0.01
        coordRegion.span.longitudeDelta = 0.01
        mapView.setRegion(coordRegion, animated: true)
        
        var area = userLocation.coordinate
        let poly = MKPolyline(coordinates:&area , count: self.coordsArray.count)
        mapView.add(poly)
        
        if let location = userLocation.location{
            if(location.speed > 0){
                self.lblSpeed.text = String(format: "%.0fkm/h",location.speed * 3.6)
            } else {
                self.lblSpeed.text = "0km/h"
            }
            
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                if let placemark = placemarks?.first{
                    self.lblCity.text = placemark.locality
                }
            })
        
        
            if(shouldTrack){
                self.coordsArray.add(userLocation.coordinate)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 2
            return polylineRenderer
        } else {
            return MKOverlayRenderer()
        }
    
    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        shouldTrack = true
    }
    
    
    @IBAction func stopTapped(_ sender: UIButton) {
        shouldTrack = false
    }
}

