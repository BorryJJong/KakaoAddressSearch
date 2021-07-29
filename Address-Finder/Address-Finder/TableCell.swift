//
//  TableClass.swift
//  Address-Finder
//
//  Created by Daye on 2021/07/29.
//

import Foundation
import UIKit

class resultTableCell : UITableViewCell {
    public var streetNameLabel = UILabel()
    public var streetNumberLabel = UILabel()
    public var shopNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //setup()
        
        contentView.addSubview(streetNameLabel)
        contentView.addSubview(streetNumberLabel)
        contentView.addSubview(shopNameLabel)
        streetNameLabel.translatesAutoresizingMaskIntoConstraints = false
        streetNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        shopNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        streetNameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        streetNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        streetNumberLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        streetNumberLabel.topAnchor.constraint(equalTo: streetNameLabel.bottomAnchor, constant: 10).isActive = true
        
        shopNameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        shopNameLabel.topAnchor.constraint(equalTo: streetNumberLabel.bottomAnchor, constant: 10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //setup()
    }
    
    private func setup(){
        streetNameLabel.textColor = .black
        streetNumberLabel.textColor = .black
        shopNameLabel.textColor = .black
        
    }
}
