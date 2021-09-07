//
//  MapViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/09/02.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController, SearchAddressPresenterDelegate {
  func presentAddress(result: [Documents]) {
    self.resultList = result
    self.addressTableView.reloadData()
  }

  let presenter = SearchAddressPresenter()
  var resultList: [Documents] = []

  let searchAddressTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    textField.placeholder = "장소 검색"
    textField.leftViewMode = .always
    textField.clearButtonMode = .whileEditing
    textField.rightViewMode = UITextField.ViewMode.always
    textField.borderStyle = .roundedRect
    textField.clearButtonMode = .whileEditing
    return textField
  }()
  let addressTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorInset.right = tableView.separatorInset.left
    tableView.register(AddressTableCell.classForCoder(), forCellReuseIdentifier: "cell")
    tableView.allowsSelection = true
    tableView.isHidden = true
    return tableView
  }()
  let searchStatusImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "map.svg")
    imageView.isHidden = true
    return imageView
  }()
  let searchStatusLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .gray
    label.text = "검색어를 입력하세요"
    label.isHidden = true
    return label
  }()
  //  let searchAddressTextFieldLeftButton: UIButton = {
  //      let button = UIButton()
  //      button.setImage(UIImage(named: "search.svg"), for: .normal)
  //      button.frame = CGRect(x: 5, y: 0, width: 36, height: 36)
  //      button.addTarget(self, action: #selector(didGoBackButtonClicked), for: .touchUpInside)
  //      return button
  //  }()
  var mapView = NMFMapView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

  override func viewDidLoad() {
    super.viewDidLoad()

    presenter.setViewDelegate(delegate: self)
    setView()
    layout()

    self.searchAddressTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    hideKeyboard()

  }
  
  private func setView() {
    view.backgroundColor = .white
    searchAddressTextField.delegate = self

    addressTableView.delegate = self
    addressTableView.dataSource = self

    view.addSubview(mapView)
    view.addSubview(addressTableView)
    view.addSubview(searchAddressTextField)
    view.addSubview(searchStatusImageView)
    view.addSubview(searchStatusLabel)
  }

  private func layout() {
    searchAddressTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    searchAddressTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    searchAddressTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
    searchAddressTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true

    searchStatusImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    searchStatusImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    searchStatusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    searchStatusLabel.topAnchor.constraint(equalTo: searchStatusImageView.bottomAnchor, constant: 20).isActive = true

    addressTableView.topAnchor.constraint(equalTo: searchAddressTextField.bottomAnchor).isActive = true
    addressTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    addressTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    addressTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
  }

  //  @objc func didGoBackButtonClicked() {
  //    hideKeyboard()
  //    mapView.isHidden = false
  //
  //  }

  func startSearching(isSuccess: Bool) {
    searchStatusImageView.isHidden = true
    searchStatusLabel.isHidden = true

    if isSuccess {
      showResult()
    } else {
      searchStatusImageView.image = UIImage(named: "noResult.svg")
      searchStatusLabel.text = "검색 결과가 없습니다"
      hideTable()
    }
  }

  func showResult() {
    searchStatusImageView.isHidden = true
    searchStatusLabel.isHidden = true
  }

  func hideTable() {
    searchStatusImageView.isHidden = false
    searchStatusLabel.isHidden = false
  }

  @objc func textFieldDidBeginEditing(_ textField: UITextField) {
    mapView.isHidden = true
    addressTableView.isHidden = false
  }

  @objc func textFieldDidChange(_ sender: Any?) {
    if let keyword = searchAddressTextField.text {
      presenter.doSearchAddress(keyword: keyword)
      if resultList.isEmpty {
        startSearching(isSuccess: false)
      } else {
        startSearching(isSuccess: true)
      }
    } else {
      presenter.doSearchAddress(keyword: " ")
      startSearching(isSuccess: false)
    }
  }
}
extension MapViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return resultList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let addressTableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AddressTableCell else {
      return .init()
    }

    let placeName = resultList[indexPath.row].placeName
    let roadAddress = resultList[indexPath.row].roadAddressName
    let jibeonAddress = resultList[indexPath.row].addressName
    // print(resultList[indexPath.row].longtitude)

    addressTableCell.setData(placeName: placeName, roadAddress: roadAddress, jibeonAddress: jibeonAddress)

    return addressTableCell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let detailViewController = AddressDetailViewController()

    detailViewController.selectedLocation.longitude = Double(resultList[indexPath.row].longtitude) ?? 0
    detailViewController.selectedLocation.latitude = Double(resultList[indexPath.row].latitude) ?? 0

    navigationController?.pushViewController(detailViewController, animated: true)
  }
}

extension MapViewController: UITableViewDelegate {
}

extension MapViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    addressTableView.isHidden = true
    if let keyword = searchAddressTextField.text {
      presenter.doSearchAddress(keyword: keyword)
      if resultList.isEmpty {
        startSearching(isSuccess: false)
      } else {
        startSearching(isSuccess: true)
      }
    } else {
      presenter.doSearchAddress(keyword: " ")
      startSearching(isSuccess: false)
    }
    return true
  }
}
