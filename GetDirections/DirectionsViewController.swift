//
//  DirectionsViewController.swift
//  GetDirections
//
//  Created by Luis Puentes on 7/21/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit
import MapKit

class DirectionsViewController: UIViewController {

    let locationManager = CLLocationManager()
    var resultSearchController: UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // This is setting up the tableview to take over the screen when we search for something
        let locationSearchTable = storyboard?.instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        // Creating the actual Search Bar and embedding it in the nav bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places..."
        navigationItem.titleView = resultSearchController?.searchBar
        
        // Customizing the presentation of the search results
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
    }
    
//        mapView.showsScale = true
//        mapView.showsPointsOfInterest = true
//        mapView.showsUserLocation = true
//        
//        locationManager.requestAlwaysAuthorization()
//        locationManager.requestWhenInUseAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//        }
//        
//        guard let sourceCoordinates = locationManager.location?.coordinate else { return }
//        let destCoordinates = CLLocationCoordinate2DMake(39.7439, 105.0201)
//        
//        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates)
//        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
//        
//        let sourceItem = MKMapItem(placemark: sourcePlacemark)
//        let destItem = MKMapItem(placemark: destPlacemark)
//        
//        let directionRequest = MKDirectionsRequest()
//        directionRequest.source = sourceItem
//        directionRequest.destination = destItem
//        directionRequest.transportType = .any
//        
//        let directions = MKDirections(request: directionRequest)
//        directions.calculate { (response, error) in
//            guard let response = response else {
//                if let error = error {
//                    print("Something went wrong: \(error)")
//                }
//                return
//            }
//            
//            let route = response.routes[0]
//            self.mapView.add(route.polyline, level: .aboveRoads)
//            
//            let rekt = route.polyline.boundingMapRect
//            self.mapView.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
//        }
    
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        let renderer = MKPolylineRenderer(overlay: overlay)
//        renderer.strokeColor = .blue
//        renderer.lineWidth = 5.0
//        
//        return renderer
//    }
    @IBOutlet weak var mapView: MKMapView!
}

extension DirectionsViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            DispatchQueue.main.async {
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
}
