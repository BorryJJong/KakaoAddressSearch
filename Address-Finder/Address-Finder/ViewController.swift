//
//  ViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/27.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var addressSearchButton = UIButton()
    var addressTableView = UITableView()
    var addressSearchTextField = UITextField()
    var resultList: [Documents] = []
    var backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSet()
        layout()
        hideKeyboard()
    }
    
    func viewSet() {
        view.backgroundColor = .white
        
        backgroundImageView.image = UIImage(named: "map.svg")
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "주소 검색"
        
        addressSearchTextField.placeholder = "Search Address"
        addressSearchTextField.leftViewMode = .always
        addressSearchTextField.clearButtonMode = .whileEditing
        
        addressSearchButton.setImage(UIImage(named: "search.svg"), for: .normal)
        addressSearchButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        addressSearchButton.addTarget(self, action: #selector(self.didSearchButtonClicked), for: .touchUpInside)
        addressSearchTextField.rightView = addressSearchButton
        addressSearchTextField.rightViewMode = UITextField.ViewMode.always
        addressSearchTextField.delegate = self
        addressSearchTextField.borderStyle = .roundedRect
        
        addressTableView = UITableView()
        addressTableView.isHidden = true

        addressTableView.separatorInset.right = addressTableView.separatorInset.left
        addressTableView.delegate = self
        addressTableView.dataSource = self
        addressTableView.register(AddressTableCell.classForCoder(), forCellReuseIdentifier: "cell")

        view.addSubview(addressSearchTextField)
        view.addSubview(backgroundImageView)
        view.addSubview(addressTableView)
    }
    
    func layout() {
        addressSearchTextField.translatesAutoresizingMaskIntoConstraints = false
        addressSearchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        addressSearchTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        addressSearchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addressSearchTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        addressSearchTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        addressTableView.translatesAutoresizingMaskIntoConstraints = false
        addressTableView.topAnchor.constraint(equalTo: addressSearchTextField.bottomAnchor).isActive = true
        addressTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        addressTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addressTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }
    
    @objc func didSearchButtonClicked() {
        if let keyword = addressSearchTextField.text {
            doSearchAddress(keyword: keyword)
        } else {
            doSearchAddress(keyword: " ")
            //self.addressTableView.isHidden = true
        }
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
                        self.addressTableView.isHidden = false
                        let jsonData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                        let getInstanceData = try JSONDecoder().decode(APIResponse.self, from: jsonData)
                        self.resultList = getInstanceData.documents
                        print(self.resultList)
                    }
                    catch {
                        print(error.localizedDescription)
                        self.addressTableView.isHidden = true
                        self.backgroundImageView.image = UIImage(named: "noResult.svg")
                    }
                
            case .failure(let error):
                print(error)
            }
        self.addressTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addressTableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddressTableCell

        if let roadAddress = resultList[indexPath.row].roadAddress?.addressName {
            addressTableCell.roadAddressLabel.text = ("도로명: ") + roadAddress
            print(addressTableCell.roadAddressLabel.text)
        }
        else {
            addressTableCell.roadAddressLabel.text = ("도로명: ")
        }

        if let jibeonAddress = resultList[indexPath.row].address?.addressName {
            addressTableCell.jibeonAddressLabel.text = ("지번: ") + jibeonAddress
            print(addressTableCell.jibeonAddressLabel.text)
        }
        else {
            addressTableCell.roadAddressLabel.text = ("지번: ")
        }
        
        return addressTableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let keyword = textField.text {
            doSearchAddress(keyword: keyword)
        } else {
            doSearchAddress(keyword: " ")
            //addressTableView.isHidden = true
            //backgroundImageView.image = UIImage(named: "noResult.svg")
        }
        return true
    }
}

extension UIViewController {
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
