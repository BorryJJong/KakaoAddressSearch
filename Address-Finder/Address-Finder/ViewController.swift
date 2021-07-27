//
//  ViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "주소 검색"
        
        let SearchController = UISearchController(searchResultsController: nil)
        SearchController.searchBar.placeholder = "Search Address"
        self.navigationItem.searchController = SearchController
    }


}

