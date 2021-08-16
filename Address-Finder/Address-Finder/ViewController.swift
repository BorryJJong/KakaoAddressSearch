//
//  ViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/27.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    let addressSearchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search.svg"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        button.addTarget(self, action: #selector(didSearchButtonClicked), for: .touchUpInside)
        return button
    }()
    let addressTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    }()
    let addressSearchTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.placeholder = "Search Address"
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.rightViewMode = UITextField.ViewMode.always
        textField.borderStyle = .roundedRect
        return textField
    }()
    let backgroundImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "map.svg")
        return imageView
    }()
    let backgroudmessageLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    var resultList: [Documents] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        layout()
        hideKeyboard()
    }
    
    private func setView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "주소 검색"

        addressSearchTextField.rightView = addressSearchButton
        addressSearchTextField.delegate = self
        
        addressTableView.isHidden = true
        addressTableView.separatorInset.right = addressTableView.separatorInset.left
        addressTableView.delegate = self
        addressTableView.dataSource = self
        addressTableView.register(AddressTableCell.classForCoder(), forCellReuseIdentifier: "cell")

        view.addSubview(addressSearchTextField)
        view.addSubview(backgroundImageView)
        view.addSubview(addressTableView)
    }
    
    private func layout() {
        addressSearchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        addressSearchTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        addressSearchTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        addressSearchTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true

        backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
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
        }
    }
    
    func doSearchAddress(keyword: String) {
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 754d4ea04671ab9d7e2add279d718b0e" ]
        let parameters: [String: Any] = [ "query": keyword ]
        
        Alamofire.request(
            "https://dapi.kakao.com/v2/local/search/address.json",
            method: .get,
            parameters: parameters,
            headers: headers
        ).responseData{ response in
            switch response.result {
            case .success(let result):
                    do {
                        self.addressTableView.isHidden = false
                        let getInstanceData = try JSONDecoder().decode(APIResponse.self, from: result)
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
        
        let roadAddress = resultList[indexPath.row].roadAddress?.addressName ?? " "
        let jibeonAddress = resultList[indexPath.row].address?.addressName ?? " "

        addressTableCell.setData(roadAddress: roadAddress, jibeonAddress: jibeonAddress)
        
        return addressTableCell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let keyword = textField.text {
            doSearchAddress(keyword: keyword)
        } else {
            doSearchAddress(keyword: " ")
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
