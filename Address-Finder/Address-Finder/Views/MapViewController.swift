//
//  MapViewController.swift
//  Address-Finder
//
//  Created by Daye on 2021/09/02.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setView()
    layout()
    
  }
  
  private func setView() {
    view.backgroundColor = .white
    
    let mapView = NMFMapView(frame: view.frame)
    view.addSubview(mapView)
    
  }
  
  private func layout() {
    
  }
}
