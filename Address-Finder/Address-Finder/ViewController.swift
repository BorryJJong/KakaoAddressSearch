//
//  ViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/27.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    var searchButton = UIButton()
    var resultTableView: UITableView!
    var resultList = ["1","2","3","4","5"]
    //var textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
        layout()
    }
    
    func viewSet(){
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "주소 검색"

        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        let textField = UITextField(frame: header.bounds)
        textField.placeholder = "Search Address"
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        
        searchButton.setImage(UIImage(named: "search.svg"), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        searchButton.addTarget(self, action: #selector(self.didSearchButtonClicked), for: .touchUpInside)
        textField.rightView = searchButton
        textField.rightViewMode = UITextField.ViewMode.always
        textField.delegate = self
        
        header.backgroundColor = .systemGray
        
        resultTableView = UITableView()
        resultTableView.tableHeaderView = header
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.register(resultTableCell.classForCoder(), forCellReuseIdentifier: "cell")

        header.addSubview(textField)
        header.addSubview(searchButton)
        view.addSubview(resultTableView)
    }
    
    func layout(){
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        resultTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        resultTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        resultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        resultTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }

    @objc func didSearchButtonClicked(){
        print("test")
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! resultTableCell
    
        cell.streetNameLabel.text = resultList[indexPath.row]
        cell.streetNumberLabel.text = resultList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
    
    func doSearchAddress(keyword: String){
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 754d4ea04671ab9d7e2add279d718b0e" ]
        let parameters: [String: Any] = [ "query": keyword ]
        
        Alamofire.request("https://dapi.kakao.com/v2/local/search/address.json", method: .get, parameters: parameters, headers: headers)
        
        
    }
    
}

extension ViewController: UITableViewDelegate{
    
}

//extension ViewController: UITextFieldDelegate{
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        let keyword = textField.text!
//        doSearchAddress(keyword: keyword)
//        return true
//    }
//}
