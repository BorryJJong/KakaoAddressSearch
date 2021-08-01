//
//  TableClass.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/29.
//

import Foundation
import UIKit

class AddressTableCell : UITableViewCell {
    var roadAddressLabel = UILabel()
    var jibunAddressLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewSet()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func viewSet() {
        roadAddressLabel.textColor = .black
        jibunAddressLabel.textColor = .black
        contentView.addSubview(roadAddressLabel)
        contentView.addSubview(jibunAddressLabel)
    }
    
    func layout() {
        roadAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        roadAddressLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        roadAddressLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        jibunAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        jibunAddressLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        jibunAddressLabel.topAnchor.constraint(equalTo: roadAddressLabel.bottomAnchor, constant: 10).isActive = true
        jibunAddressLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
}
