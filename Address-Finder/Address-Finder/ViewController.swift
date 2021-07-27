//
//  ViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/27.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var resultTableView: UITableView!
    var list: [String] = ["1","2","3"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! resultTableCell
        
        cell.streetNameLabel.text = list[indexPath.row]
        cell.streetNumberLabel.text = list[indexPath.row]
        cell.shopNameLabel.text = list[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "주소 검색"
        
        let SearchController = UISearchController(searchResultsController: nil)
        SearchController.searchBar.placeholder = "Search Address"
        self.navigationItem.searchController = SearchController
        
        resultTableView = UITableView()
        resultTableView.delegate = self
        resultTableView.dataSource = self
        view.addSubview(resultTableView)
        resultTableView.register(resultTableCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        resultTableView.translatesAutoresizingMaskIntoConstraints = false

        resultTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        resultTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        resultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        resultTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
         
        
    }

}

class resultTableCell : UITableViewCell {
    public var streetNameLabel = UILabel()
    public var streetNumberLabel = UILabel()
    public var shopNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //setup()
        
        contentView.addSubview(streetNameLabel)
        contentView.addSubview(streetNumberLabel)
        contentView.addSubview(shopNameLabel)
        streetNameLabel.translatesAutoresizingMaskIntoConstraints = false
        streetNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        shopNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        streetNameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        streetNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        streetNumberLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        streetNumberLabel.topAnchor.constraint(equalTo: streetNameLabel.bottomAnchor, constant: 10).isActive = true
        
        shopNameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        shopNameLabel.topAnchor.constraint(equalTo: streetNumberLabel.bottomAnchor, constant: 10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setup()
    }
    
    private func setup(){
        streetNameLabel.textColor = .black
        streetNumberLabel.textColor = .black
        shopNameLabel.textColor = .black
        
    }
}



