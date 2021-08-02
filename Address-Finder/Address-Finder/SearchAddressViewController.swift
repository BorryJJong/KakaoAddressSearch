//
//  SearchAddressViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/28.
//

import UIKit
import Alamofire

class SearchAddressViewController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)

        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]

        self.tableView.reloadData()
    }

    let tableData = ["1", "2", "3"]
    var filteredTableData = [String]()
    var addressSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "주소 검색"
        
        addressSearchController = ({
                let controller = UISearchController(searchResultsController: nil)
                controller.searchResultsUpdater = self
                controller.obscuresBackgroundDuringPresentation = false
                controller.searchBar.sizeToFit()

                tableView.tableHeaderView = controller.searchBar

                return controller
    })()
    
        tableView.reloadData()
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // 3
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

      if (addressSearchController.isActive) {
          cell.textLabel?.text = filteredTableData[indexPath.row]

          return cell
      }
      else {
          cell.textLabel?.text = tableData[indexPath.row]
          print(tableData[indexPath.row])
          return cell
      }
    }


    
}


