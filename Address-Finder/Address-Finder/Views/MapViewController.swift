//
//  MapViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/09/02.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController {
  
  // MARK: - Properties
  
  var location: SelectedLocation? {
    didSet {
      self.presenter.setMarker(location: self.location)
    }
  }
  let presenter = MapPresenter()
  var resultList: [Documents] = []
  
  
  // MARK: - UI
  
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
  
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
    layout()
    tapToHideKeyboard()
  }
  
  
  // MARK: - Layout
  
  private func setView() {
    view.backgroundColor = .white
    navigationController?.isNavigationBarHidden = true
    
    self.presenter.delegate = self
    
    view.addSubview(mapView)
    view.addSubview(searchAddressTextField)
  }
  
  private func layout() {
    searchAddressTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    searchAddressTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    searchAddressTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
    searchAddressTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
  }
  
  private func setCamera(selectedLocation: SelectedLocation?) {
    let camPosition = NMGLatLng(lat: selectedLocation?.latitude ?? 0, lng: selectedLocation?.longitude ?? 0)
    let cameraUpdate = NMFCameraUpdate(scrollTo: camPosition)
    
    mapView.moveCamera(cameraUpdate)
  }
  
  private func setMarker(selectedLocation: SelectedLocation?) {
    let marker = NMFMarker()
    
    marker.position = NMGLatLng(lat: selectedLocation?.latitude ?? 0, lng: selectedLocation?.longitude ?? 0)
    marker.iconImage = NMF_MARKER_IMAGE_BLACK
    marker.iconTintColor = UIColor.red
    marker.width = 25
    marker.height = 30
    marker.mapView = mapView
  }
  
  @objc func textFieldDidBeginEditing(_ textField: UITextField) {
    let searchAddressView = SearchAddressViewController()
    self.navigationController?.pushViewController(searchAddressView, animated: false)
  }
}

extension MapViewController: MapPresenterDelegate {
  func setMarker(location: SelectedLocation?) {
    self.setCamera(selectedLocation: location)
    self.setMarker(selectedLocation: location)
  }
}
