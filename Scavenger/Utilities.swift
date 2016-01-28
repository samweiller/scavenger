//
//  Utilities.swift
//  Geotify
//
//  Adapted from Ken Toh

import UIKit
import MapKit


func showSimpleAlertWithTitle(title: String!, message: String, viewController: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let action = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
    alert.addAction(action)
    dispatch_async(dispatch_get_main_queue(), {
        viewController.presentViewController(alert, animated: true, completion: nil)
    })

//    viewController.presentViewController(alert, animated: true, completion: nil)
}

// this is for Apple maps. Should change for Gmaps
func zoomToUserLocationInMapView(mapView: MKMapView) {
    if let coordinate = mapView.userLocation.location?.coordinate {
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
        mapView.setRegion(region, animated: true)
    }
}
