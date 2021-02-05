//
//  DownloadImageTableViewCell.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/2/4.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit

class DownloadImageTableViewCell: UITableViewCell {

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
    
    lazy var girlsImg: UIImageView = {
        self.contentView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        $0.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        return $0
    }(UIImageView())
    
    func configImageWith(_ imgurl: String) {
        girlsImg.image = DownloaderManager.downloadImageWithURL(imgurl)
        girlsImg.clipsToBounds = true
        girlsImg.contentMode = .scaleAspectFill
    }
}
