//
//  ViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/27.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var searchButton = UIButton()
    var resultTableView: UITableView!
    var resultList: [Address] = []
    //var textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
        layout()
        hideKeyboard()
    }
    
    func viewSet(){
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "주소 검색"

        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        let textField = UITextField(frame: CGRect(x: 20, y: 0, width: view.frame.size.width - 40, height: 40))
        textField.placeholder = "Search Address"
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        
        searchButton.setImage(UIImage(named: "search.svg"), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        searchButton.addTarget(self, action: #selector(self.didSearchButtonClicked), for: .touchUpInside)
        textField.rightView = searchButton
        textField.rightViewMode = UITextField.ViewMode.always
        textField.delegate = self
        textField.borderStyle = .roundedRect
        
        resultTableView = UITableView()
        resultTableView.tableHeaderView = header
        //resultTableView.separatorInset.right = resultTableView.separatorInset.left
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
        let text = "판교역로 235"
        
        print("test")
        doSearchAddress(keyword: text)
    }
    
    func doSearchAddress(keyword: String){
        //var result = [Address]()
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 754d4ea04671ab9d7e2add279d718b0e" ]
        let parameters: [String: Any] = [ "query": keyword ]
        
        Alamofire.request("https://dapi.kakao.com/v2/local/search/address.json",
                          method: .get,
                          parameters: parameters,
                          headers: headers)
            .responseJSON(completionHandler: { response in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    if let addressList = JSON(value)["documents"].array {
                        for item in addressList{
                            let streetAddr = item["road_address"]["address_name"].string ?? ""
                            //let Addr = JSON(value)["address"]
                            //let jibunAddr = item["zip_code"].string ?? ""
                        
                            let jibunAddr = item["address"]["address_name"].string ?? ""
                            self.resultList.append(Address(roadAddress: streetAddr, jibunAddress: jibunAddr))
                        }
                    }
                    self.resultTableView.reloadData()
                case .failure(_):
                    debugPrint(Error.self)
                }
        })
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! resultTableCell
    
        cell.roadAddressLabel.text = ("도로명: ") + resultList[indexPath.row].roadAddress
        cell.jibunAddressLabel.text = ("지번: ") + resultList[indexPath.row].jibunAddress
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
    

}

extension ViewController: UITableViewDelegate{

}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let text = "정왕동"
        doSearchAddress(keyword: text)
        
        return true
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

