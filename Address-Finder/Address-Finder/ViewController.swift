//
//  ViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/27.
//

import UIKit
import Alamofire
//import SwiftyJSON

class ViewController: UIViewController {
    
    var addressSearchButton = UIButton()
    var addressTableView: UITableView!
    var addressSearchTextField: UITextField!
    var resultList: [Documents] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
        layout()
        hideKeyboard()
    }
    
    func viewSet() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "주소 검색"

        let addressTableHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        addressSearchTextField = UITextField(frame: CGRect(x: 20, y: 0, width: view.frame.size.width - 40, height: 40))
        addressSearchTextField.placeholder = "Search Address"
        addressSearchTextField.leftViewMode = .always
        addressSearchTextField.clearButtonMode = .whileEditing
        
        addressSearchButton.setImage(UIImage(named: "search.svg"), for: .normal)
        addressSearchButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        addressSearchButton.addTarget(self, action: #selector(self.didSearchButtonClicked), for: .touchUpInside)
        addressSearchTextField.rightView = addressSearchButton
        addressSearchTextField.rightViewMode = UITextField.ViewMode.always
        addressSearchTextField.delegate = self
        addressSearchTextField.borderStyle = .none
        
        addressTableView = UITableView()
        addressTableView.tableHeaderView = addressTableHeader
        addressTableView.separatorInset.right = addressTableView.separatorInset.left
        addressTableView.delegate = self
        addressTableView.dataSource = self
        addressTableView.register(AddressTableCell.classForCoder(), forCellReuseIdentifier: "cell")

        addressTableHeader.addSubview(addressSearchTextField)
        addressTableHeader.addSubview(addressSearchButton)
        view.addSubview(addressTableView)
    }
    
    func layout() {
        addressTableView.translatesAutoresizingMaskIntoConstraints = false
        addressTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        addressTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        addressTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addressTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }
    
    @objc func didSearchButtonClicked() {
        let keyword = checkNil(addressSearchTextField.text)
        doSearchAddress(keyword: keyword)
    }
    
    func doSearchAddress(keyword: String) {
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 754d4ea04671ab9d7e2add279d718b0e" ]
        let parameters: [String: Any] = [ "query": keyword ]
        
        Alamofire.request("https://dapi.kakao.com/v2/local/search/address.json",
                          method: .get,
                          parameters: parameters,
                          headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let result):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                        let getInstanceData = try JSONDecoder().decode(APIResponse.self, from: jsonData)
                        self.resultList = getInstanceData.documents
                        print(self.resultList)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                self.addressTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddressTableCell
        let roadAddress = checkNil(resultList[indexPath.row].roadAddress?.addressName)
        let jibunAddress = checkNil(resultList[indexPath.row].address?.addressName)
        
        cell.roadAddressLabel.text = ("도로명: ") + roadAddress
        cell.jibunAddressLabel.text = ("지번: ") + jibunAddress

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doSearchAddress(keyword: checkNil(textField.text))

        return true
    }
}

extension UIViewController {
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

func checkNil(_ text: String?) -> String{
    if text == nil {
        return " "
    }
    return text!
}
