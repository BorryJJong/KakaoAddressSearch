//
//  AddressDetailViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/08/28.
//

import UIKit
import NMapsMap

class AddressDetailViewController: UIViewController {
  
  let presenter = SearchAddressPresenter()
  let mapView = NMFMapView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
  
  var selectedLocation = SelectedLocation(latitude: 37.345455350524844, longitude: 126.68751058508818)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("call?")
    setMarker()
    setCamera()
    
    view.addSubview(mapView)
  }
  
  func setCamera() {
    let camPosition = NMGLatLng(lat: selectedLocation.latitude, lng: selectedLocation.longitude)
    let cameraUpdate = NMFCameraUpdate(scrollTo: camPosition)
    mapView.moveCamera(cameraUpdate)
  }

  func setMarker() {
    let marker = NMFMarker()

    marker.position = NMGLatLng(lat: selectedLocation.latitude, lng: selectedLocation.longitude)
    marker.iconImage = NMF_MARKER_IMAGE_BLACK
    marker.iconTintColor = UIColor.red
    marker.width = 25
    marker.height = 30
    marker.mapView = mapView
  }

}
