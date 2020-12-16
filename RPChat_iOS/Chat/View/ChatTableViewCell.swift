//
//  ChatTableViewCell.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2020/12/15.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell, ChatCellProtocol {
    var nickeNameLab: UILabel = UILabel()
    var headerImg: UIImageView = UIImageView()
    var messageRootView: UIView = UIView()
    var messageLab: UILabel = UILabel()

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
    
    private func configUI() {
        contentView.addSubview(headerImg)
        headerImg.translatesAutoresizingMaskIntoConstraints = false
        headerImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        headerImg.widthAnchor.constraint(equalToConstant: 50).isActive = true
        headerImg.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        contentView.addSubview(nickeNameLab)
        nickeNameLab.translatesAutoresizingMaskIntoConstraints = false
        nickeNameLab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        nickeNameLab.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func configReceivedUI() {
        headerImg.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12).isActive = true
        
        nickeNameLab.leftAnchor.constraint(equalTo: headerImg.rightAnchor, constant: 8).isActive = true
        nickeNameLab.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
    }
    
    private func configSendUI() {
        headerImg.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12).isActive = true
        
        
    }
    
}
