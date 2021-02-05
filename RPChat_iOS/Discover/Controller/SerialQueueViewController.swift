//
//  SerialQueueViewController.swift
//  RPChat_iOS
//
//  Created by rp.wang on 2021/2/4.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit
import RPChatDataKit
import RPChatUIKit

class SerialQueueViewController: QueueBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenBackTitle()
        title = NSLocalizedString("Serial Queue", comment: "")
        // Do any additional setup after loading the view.
        slider.thumbTintColor = .hexStringToColor("#1aaba8")
        
        fpsLab.isHidden = false
    }
   
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        configImage()
        if fpsLab.isHidden == true {
            fpsLab.isHidden = false
        }
    }
    
    func configImage() {
        // 创建串行队列
        let serialQueue = DispatchQueue(label: "TSN.RPChat.io")
        var upImg: UIImageView? = nil
        
        for (index, imgurl) in DownloaderManager.imageArray.enumerated() {
            let girlsImg = UIImageView()
            containerView.addSubview(girlsImg)
            girlsImg.translatesAutoresizingMaskIntoConstraints = false
            girlsImg.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
            girlsImg.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
            girlsImg.heightAnchor.constraint(equalToConstant: 180).isActive = true
            
            if index == 0 {
                girlsImg.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
            } else {
                girlsImg.topAnchor.constraint(equalTo: upImg!.bottomAnchor, constant: 8).isActive = true
            }
            
            // 最后一张图片
            if index == DownloaderManager.imageArray.count - 1 {
                girlsImg.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
            }
            
            serialQueue.async {
                let image = DownloaderManager.downloadImageWithURL(imgurl)
                DispatchQueue.main.async {
                    girlsImg.image = image
                }
            }
            girlsImg.layer.cornerRadius = 8
            girlsImg.clipsToBounds = true
            girlsImg.contentMode = .scaleAspectFill
            
            
            upImg = girlsImg
        }
        
        view.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: __screenWidth, height: containerView.frame.size.height)
    }
    
    
    lazy var containerView: UIView = {
        scrollView.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        $0.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        $0.widthAnchor.constraint(equalToConstant: __screenWidth).isActive = true
        $0.heightAnchor.constraint(greaterThanOrEqualToConstant: __screenHeight).isActive = true
        return $0
    }(UIView())
    
    lazy var scrollView: UIScrollView = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        return $0
    }(UIScrollView())
    
    lazy var slider: UISlider = {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        return $0
    }(UISlider())
}
