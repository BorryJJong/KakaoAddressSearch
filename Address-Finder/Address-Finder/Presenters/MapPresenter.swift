//
//  MapPresenter.swift
//  MapPresenter
//
//  Created by sangwon yoon on 2021/09/14.
//

import Foundation

protocol MapPresenterDelegate: AnyObject {
    func setMarker(location: SelectedLocation?)
}

class MapPresenter {
    weak var delegate: MapPresenterDelegate?
    
    func setMarker(location: SelectedLocation?) {
        self.delegate?.setMarker(location: location)
    }
}
