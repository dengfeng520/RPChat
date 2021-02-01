//
//  ContactsHeaderTableViewCell.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/2/1.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

class ContactsHeaderTableViewCell: UITableViewCell {

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
    
    /// Search
    func configSearchUI() {
        searchBar.delegate = self
    }
    
    /// Contacts
    func configHeaderUI() {
        
    }
    
    lazy var searchBar: UISearchBar = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let top = $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        let left = $0.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0)
        let right = $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0)
        let heigt = $0.heightAnchor.constraint(equalToConstant: 55)
        NSLayoutConstraint.activate([top, left, right, heigt])
        return $0
    }(UISearchBar())
}

extension ContactsHeaderTableViewCell: UISearchBarDelegate {
    
}
