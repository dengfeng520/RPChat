//
//  AddressBookTableViewCell.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/14.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit

class AddressBookTableViewCell: UITableViewCell {

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
    
    func configAddressBookData(_ withModel: AddressBookModel) {
        headerImg.image = UIImage(named: "logo_icon")
        nickNameLab.text = "寒月公主"
    }

    lazy var headerImg: UIImageView = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 4
        return $0
    }(UIImageView())
    
    lazy var nickNameLab: UILabel = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: headerImg.rightAnchor, constant: 8).isActive = true
        $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 35).isActive = true
        $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        $0.font = UIFont(name: "Helvetica-Bold", size: 20)
        return $0
    }(UILabel())
}
