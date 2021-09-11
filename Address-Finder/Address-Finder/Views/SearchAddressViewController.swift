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

//  let searchAddressButton: UIButton = {
//    let button = UIButton()
//    button.setImage(UIImage(named: "search.svg"), for: .normal)
//    button.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
//    button.addTarget(self, action: #selector(didSearchButtonClicked), for: .touchUpInside)
//    return button
//  }()
  let addressTableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorInset.right = tableView.separatorInset.left
    tableView.register(AddressTableCell.classForCoder(), forCellReuseIdentifier: "cell")
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
    presenter.setViewDelegate(delegate: self)

    setView()
    layout()
    hideKeyboard()
  }

  private func setView() {
    view.backgroundColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.title = "주소 검색"

    // searchAddressTextField.rightView = searchAddressButton
    searchAddressTextField.delegate = self

    addressTableView.isHidden = true
    addressTableView.delegate = self
    addressTableView.dataSource = self

    view.addSubview(searchAddressTextField)
    view.addSubview(searchStatusImageView)
    view.addSubview(searchStatusLabel)
    view.addSubview(addressTableView)
    view.addSubview(searchLodingIndicator)
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

    searchLodingIndicator.center = view.center

    addressTableView.topAnchor.constraint(equalTo: searchAddressTextField.bottomAnchor).isActive = true
    addressTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    addressTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    addressTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
  }

  @objc func didSearchButtonClicked() {
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
  }

  func startSearching(isSuccess: Bool) {
    let time = DispatchTime.now() + .seconds(1)

    searchStatusImageView.isHidden = true
    searchStatusLabel.isHidden = true
    searchLodingIndicator.startAnimating()

    DispatchQueue.main.asyncAfter(deadline: time) {
      self.searchLodingIndicator.stopAnimating()
      if isSuccess {
        self.showTable()
      } else {
        self.searchStatusImageView.image = UIImage(named: "noResult.svg")
        self.searchStatusLabel.text = "검색 결과가 없습니다"
        self.hideTable()
      }
    }
  }

  func showTable() {
    addressTableView.isHidden = false
    searchStatusImageView.isHidden = true
    searchStatusLabel.isHidden = true
  }

  func hideTable() {
    addressTableView.isHidden = true
    searchStatusImageView.isHidden = false
    searchStatusLabel.isHidden = false
  }

}

extension SearchAddressViewController: UITableViewDataSource {
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

//    let detailViewController = AddressDetailViewController()
//
//    detailViewController.selectedLocation.longitude = Double(resultList[indexPath.row].longtitude) ?? 0
//    detailViewController.selectedLocation.latitude = Double(resultList[indexPath.row].latitude) ?? 0
//
//    navigationController?.pushViewController(detailViewController, animated: true)
  }
}

extension SearchAddressViewController: UITableViewDelegate {
}

extension SearchAddressViewController: UITextFieldDelegate {
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
