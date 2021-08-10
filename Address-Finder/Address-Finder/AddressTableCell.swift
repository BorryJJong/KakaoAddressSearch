//
//  TableClass.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/29.
//

import UIKit

class AddressTableCell : UITableViewCell {
    var roadAddressLabel = UILabel()
    var jibeonAddressLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewSet()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func viewSet() {
        contentView.addSubview(roadAddressLabel)
        contentView.addSubview(jibeonAddressLabel)
    }
    
    func layout() {
        roadAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        roadAddressLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        roadAddressLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        jibeonAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        jibeonAddressLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        jibeonAddressLabel.topAnchor.constraint(equalTo: roadAddressLabel.bottomAnchor, constant: 10).isActive = true
        jibeonAddressLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    func setData(_ roadAddress: String, _ jibeonAddress: String){
        roadAddressLabel.text = ("도로명: ") + roadAddress
        jibeonAddressLabel.text = ("지번: ") + jibeonAddress
    }
}
