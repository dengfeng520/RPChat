//
//  AddressBookTableViewCell.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit

class ContactsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var headerImg: UIImageView = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    lazy var nickNameLab: UILabel = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: headerImg.rightAnchor, constant: 8).isActive = true
        $0.topAnchor.constraint(equalTo: headerImg.topAnchor, constant: 5).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
        $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        $0.font = UIFont(name: "Helvetica-Bold", size: 16.5)
        return $0
    }(UILabel())
    
    lazy var subMessageLab: UILabel = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: headerImg.rightAnchor, constant: 8).isActive = true
        $0.bottomAnchor.constraint(equalTo: headerImg.bottomAnchor, constant: -3).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 17).isActive = true
        $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        $0.textColor = .subTextColor
        $0.font = UIFont.systemFont(ofSize: 15)
        return $0
    }(UILabel())
    
    lazy var searchBar: UISearchBar = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let top = $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        let left = $0.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0)
        let right = $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0)
        let heigt = $0.heightAnchor.constraint(equalToConstant: 55)
        NSLayoutConstraint.activate([top, left, right, heigt])
        $0.delegate = self
        $0.placeholder = NSLocalizedString("Search", comment: "")
        return $0
    }(UISearchBar())
}

extension ContactsTableViewCell: UISearchBarDelegate {
    /// Contacts
    func configContactsData(_ model: ContactsModel) {
        headerImg.image = UIImage(named: model.picture)
        nickNameLab.text = model.name
        subMessageLab.text = model.introduction
        
        searchBar.isHidden = true
        headerImg.isHidden = false
        nickNameLab.isHidden = false
        subMessageLab.isHidden = false
    }
    
    /// Search
    func configSearchUI() {
        searchBar.isHidden = false
        
        headerImg.isHidden = true
        nickNameLab.isHidden = true
        subMessageLab.isHidden = true
    }
}
