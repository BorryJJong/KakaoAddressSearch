//
//  MapViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/09/02.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController, SearchAddressPresenterDelegate, UITextFieldDelegate {
  func presentAddress(result: [Documents]) {
    self.resultList = result
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
  lazy var mapView = NMFMapView(frame: view.frame)

  override func viewDidLoad() {
    super.viewDidLoad()

    setView()
    layout()

    hideKeyboard()

  }
  
  private func setView() {
    view.backgroundColor = .white
    navigationController?.isNavigationBarHidden = true

    searchAddressTextField.delegate = self

    view.addSubview(mapView)
    view.addSubview(searchAddressTextField)
  }

  private func layout() {
    searchAddressTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    searchAddressTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    searchAddressTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
    searchAddressTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
  }

  @objc func textFieldDidBeginEditing(_ textField: UITextField) {
    print("black")
    //push search 화면
    let searchAddressView = SearchAddressViewController()
    self.navigationController?.pushViewController(searchAddressView, animated: false)
  }
}
