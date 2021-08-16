//
//  TableClass.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/29.
//

import UIKit

class AddressTableCell : UITableViewCell {
    let roadAddressLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let jibeonAddressLabel : UILabel = {
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
        contentView.addSubview(roadAddressLabel)
        contentView.addSubview(jibeonAddressLabel)
    }
    
    func layout() {
        roadAddressLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        roadAddressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        roadAddressLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        
        jibeonAddressLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        jibeonAddressLabel.topAnchor.constraint(equalTo: roadAddressLabel.bottomAnchor, constant: 10).isActive = true
        jibeonAddressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        jibeonAddressLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    }
    
    func setData(roadAddress: String, jibeonAddress: String){
        roadAddressLabel.text = ("도로명: ") + roadAddress
        jibeonAddressLabel.text = ("지번: ") + jibeonAddress
    }
}
