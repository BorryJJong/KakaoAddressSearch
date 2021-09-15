//
//  MapPresenter.swift
//  Address-Finder
//
//  Created by Daye on 2021/09/14.
//

import Foundation
import NMapsMap

protocol MapPresenterDelegate: AnyObject {
  func setMarkerLocation(location: SelectedLocation?)
  func setCamera(location: SelectedLocation?)
}

class MapPresenter {

  // MARK: - Properties

  weak var delegate: MapPresenterDelegate?

  // MARK: - Functions

  func setMarker(location: SelectedLocation?) {
    self.delegate?.setMarkerLocation(location: location)
    self.delegate?.setCamera(location: location)
  }
}
