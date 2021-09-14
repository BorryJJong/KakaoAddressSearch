//
//  ViewController.swift
//  Practice_MVC_AddressFinder
//
//  Created by Daye on 2021/08/24.
//

import UIKit

class SearchAddressViewController: UIViewController, SearchAddressPresenterDelegate {
  func presentAddress(result: [Documents]) {
    self.resultList = result
    self.addressTableView.reloadData()
  }
  
  let presenter = SearchAddressPresenter()
  var resultList: [Documents] = []
  
  let addressTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorInset.right = tableView.separatorInset.left
    tableView.register(AddressTableCell.self, forCellReuseIdentifier: "cell")
    tableView.allowsSelection = true
    return tableView
  }()
  
  let searchAddressTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    textField.placeholder = "장소 검색"
    textField.leftViewMode = .always
    textField.clearButtonMode = .whileEditing
    textField.rightViewMode = UITextField.ViewMode.always
    textField.borderStyle = .roundedRect
    return textField
  }()
  
  let searchStatusImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "map.svg")
    return imageView
  }()
  
  let searchStatusLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .gray
    label.text = "검색어를 입력하세요"
    return label
  }()
  
  let searchLodingIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    return activityIndicator
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter.setViewDelegate(delegate: self)
    
    self.setView()
    self.layout()
    self.showKeyboard()
    self.tapToHideKeyboard()
  }
  
  private func setView() {
    self.view.backgroundColor = .white
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.title = "주소 검색"
    
    self.searchAddressTextField.delegate = self
    
    self.addressTableView.isHidden = true
    self.addressTableView.delegate = self
    self.addressTableView.dataSource = self
    
    self.view.addSubview(self.searchAddressTextField)
    self.view.addSubview(self.searchStatusImageView)
    self.view.addSubview(self.searchStatusLabel)
    self.view.addSubview(self.addressTableView)
    self.view.addSubview(self.searchLodingIndicator)
  }
  
  private func layout() {
    self.searchAddressTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    self.searchAddressTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    self.searchAddressTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
    self.searchAddressTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
    
    self.searchStatusImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    self.searchStatusImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    
    self.searchStatusLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    self.searchStatusLabel.topAnchor.constraint(equalTo: self.searchStatusImageView.bottomAnchor, constant: 20).isActive = true
    
    self.searchLodingIndicator.center = self.view.center
    
    self.addressTableView.topAnchor.constraint(equalTo: self.searchAddressTextField.bottomAnchor).isActive = true
    self.addressTableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    self.addressTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    self.addressTableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
  }
  
  private func startSearching(isSuccess: Bool) {
    let time = DispatchTime.now() + .seconds(1)
    
    self.searchStatusImageView.isHidden = true
    self.searchStatusLabel.isHidden = true
    self.searchLodingIndicator.startAnimating()
    
    DispatchQueue.main.asyncAfter(deadline: time) {
      self.searchLodingIndicator.stopAnimating()
      if isSuccess && !self.resultList.isEmpty {
        self.showTable()
      } else {
        self.searchStatusImageView.image = UIImage(named: "noResult.svg")
        self.searchStatusLabel.text = "검색 결과가 없습니다"
        self.hideTable()
      }
    }
    self.resultList = []
  }
  
  private func showKeyboard() {
    searchAddressTextField.becomeFirstResponder()
  }
  
  private func showTable() {
    self.addressTableView.isHidden = false
    self.searchStatusImageView.isHidden = true
    self.searchStatusLabel.isHidden = true
  }
  
  private func hideTable() {
    self.addressTableView.isHidden = true
    self.searchStatusImageView.isHidden = false
    self.searchStatusLabel.isHidden = false
  }
}

extension SearchAddressViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return resultList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let addressTableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AddressTableCell else {
      return .init()
    }
    
    let placeName = self.resultList[indexPath.row].placeName
    let roadAddress = self.resultList[indexPath.row].roadAddressName
    let jibeonAddress = self.resultList[indexPath.row].addressName
    
    addressTableCell.setData(placeName: placeName, roadAddress: roadAddress, jibeonAddress: jibeonAddress)
    
    return addressTableCell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedLocation = SelectedLocation(
      latitude: Double(resultList[indexPath.row].latitude) ?? 0,
      longitude: Double(resultList[indexPath.row].longtitude) ?? 0
    )
    
    /// 현재 네비게이션뷰에서 가장 첫번째 뷰컨에 접근하여 캐스팅 작업
    /// viewControllers[0] -> MapViewController
    /// viewControllers[1] -> SearchAddressViewController 라고 볼 수 있음 현재
    if let parentView = self.navigationController?.viewControllers[0] as? MapViewController {
      parentView.presenter.setMarker(location: selectedLocation)
    }
    
    self.navigationController?.popViewController(animated: false)
  }
}

extension SearchAddressViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.addressTableView.isHidden = true
    
    if let keyword = self.searchAddressTextField.text {
      self.presenter.doSearchAddress(keyword: keyword)
      self.startSearching(isSuccess: true)
    } else {
      self.startSearching(isSuccess: false)
    }
    return true
  }
}
