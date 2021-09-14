//
//  TableClass.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/29.
//

import UIKit

class AddressTableCell: UITableViewCell {
    
  let placeNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
    
  let roadAddressLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
    
  let jibeonAddressLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
  super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setView()
    self.layout()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  func setView() {
    self.contentView.addSubview(self.placeNameLabel)
    self.contentView.addSubview(self.roadAddressLabel)
    self.contentView.addSubview(self.jibeonAddressLabel)
  }

  func layout() {
    self.placeNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
    self.placeNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
    self.placeNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 10).isActive = true

    self.roadAddressLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
    self.roadAddressLabel.topAnchor.constraint(equalTo: self.placeNameLabel.bottomAnchor, constant: 10).isActive = true
    self.roadAddressLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true

    self.jibeonAddressLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
    self.jibeonAddressLabel.topAnchor.constraint(equalTo: self.roadAddressLabel.bottomAnchor, constant: 10).isActive = true
    self.jibeonAddressLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    self.jibeonAddressLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
  }

  func setData(placeName: String, roadAddress: String, jibeonAddress: String) {
    self.placeNameLabel.text = placeName
    self.roadAddressLabel.text = ("도로명: ") + roadAddress
    self.jibeonAddressLabel.text = ("지번: ") + jibeonAddress
  }
}
