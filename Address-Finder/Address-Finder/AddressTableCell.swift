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
//    public var shopNameLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //setup()
        
        contentView.addSubview(roadAddressLabel)
        contentView.addSubview(jibunAddressLabel)
        //contentView.addSubview(shopNameLabel)
        roadAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        jibunAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        //shopNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        roadAddressLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        roadAddressLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        //roadAddressLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 15).isActive = true
        
        jibunAddressLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        jibunAddressLabel.topAnchor.constraint(equalTo: roadAddressLabel.bottomAnchor, constant: 5).isActive = true
        //jibunAddressLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 15).isActive = true
        
//        shopNameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
//        shopNameLabel.topAnchor.constraint(equalTo: streetNumberLabel.bottomAnchor, constant: 10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup(){
        roadAddressLabel.textColor = .black
        jibunAddressLabel.textColor = .black
    }
}
