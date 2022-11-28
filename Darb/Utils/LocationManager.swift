//
//  LocationManager.swift
//  Darb
//
//  Created by Naveed ur Rehman on 26/11/2022.
//

import UIKit
import CoreLocation

protocol LocationDelegate {
    
    func didUpdateLocation(location: CLLocation)
    func didChangeAuthorization(status:CLAuthorizationStatus)
    func didUpdateHeading(heading:CLHeading)
}

class LocationManager: NSObject,CLLocationManagerDelegate{
    
    static let sharedManager = LocationManager()
    let manager : CLLocationManager!
    var delegate : LocationDelegate?
    
    override init() {
        manager = CLLocationManager()
        super.init()
        manager.delegate = self
        manager.pausesLocationUpdatesAutomatically = false
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.requestAlwaysAuthorization()
        startUpdatingLocations()
    }
    
    func startUpdatingLocations(){
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
    
    func stopUpdatingLocations(){
        manager.stopUpdatingLocation()
    }
    
    func checkLocationPermissoins()->CLAuthorizationStatus{
        switch CLLocationManager.authorizationStatus(){
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorizedAlways:
            return .authorizedAlways
        case .authorizedWhenInUse:
            return .authorizedWhenInUse
        @unknown default:
            fatalError("location not found")
        }
    }
   
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse  {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    self.startUpdatingLocations()
                }
            }
        }
        delegate?.didChangeAuthorization(status: status)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        delegate?.didUpdateHeading(heading: newHeading)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            delegate?.didUpdateLocation(location: location)
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}

