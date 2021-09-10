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
    setView()
    layout()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  func setView() {
    contentView.addSubview(placeNameLabel)
    contentView.addSubview(roadAddressLabel)
    contentView.addSubview(jibeonAddressLabel)
  }

  func layout() {
    placeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    placeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    placeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10).isActive = true

    roadAddressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    roadAddressLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 10).isActive = true
    roadAddressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

    jibeonAddressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    jibeonAddressLabel.topAnchor.constraint(equalTo: roadAddressLabel.bottomAnchor, constant: 10).isActive = true
    jibeonAddressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    jibeonAddressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
  }

  func setData(placeName: String, roadAddress: String, jibeonAddress: String) {
    placeNameLabel.text = placeName
    roadAddressLabel.text = ("도로명: ") + roadAddress
    jibeonAddressLabel.text = ("지번: ") + jibeonAddress
  }
}
