//
//  MyExtensions.swift
//  MusicVideo
//
//  Created by Michael Rudowsky on 1/26/16.
//  Copyright © 2016 Michael Rudowsky. All rights reserved.
//

import UIKit


extension MusicVideoTVC: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text!.lowercaseString
        filterSearch(searchController.searchBar.text!)
    }
}