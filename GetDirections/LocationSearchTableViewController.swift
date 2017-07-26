//
//  LocationSearchTableViewController.swift
//  GetDirections
//
//  Created by Luis Puentes on 7/26/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTableViewController: UITableViewController {

    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    // MARK: - Table view data source
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
//
//    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else { return }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

extension LocationSearchTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
    }
}

