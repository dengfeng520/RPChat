//
//  DownloaderManager.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2021/2/3.
//  Copyright © 2021 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import UIKit

public class DownloaderManager: NSObject {
    // 单例
    public static let downloaderManager = DownloaderManager()
    // 即然是单例，就禁止其他地方初始化
    private override init() {
        super.init()
    }
    // 图片缓存,用图片的URL作为Key
    private let cacheImage = NSCache<NSURL, UIImage>()
    // 
    
    public class func downloadImageWithURL(_ url: String) -> UIImage? {
        guard let data = try? Data(contentsOf: URL(string: url)!) else { return nil }
        return UIImage(data: data)
    }
    
    public static let imageArray: [String] = {
            return ["https://icweiliimg1.pstatp.com/weili/l/1004278940027060246.webp",
                    "https://icweiliimg6.pstatp.com/weili/l/1004279008745226253.webp",
                    "https://icweiliimg6.pstatp.com/weili/l/1004278708096466983.webp",
                    "https://icweiliimg9.pstatp.com/weili/l/1004278699507580957.webp",
                    "https://weiliicimg1.pstatp.com/weili/l/1004279060284833814.webp",
                    "https://icweiliimg1.pstatp.com/weili/l/1004279292212019223.webp",
                    "https://weiliicimg9.pstatp.com/weili/l/1004278793995812908.webp",
                    "https://icweiliimg6.pstatp.com/weili/l/1004279077463654499.webp",
                    "https://weiliicimg1.pstatp.com/weili/l/1004279051693850719.webp",
                    "https://icweiliimg9.pstatp.com/weili/l/1004278922845880333.webp",
                    "https://weiliicimg6.pstatp.com/weili/l/705631043388440605.jpg",
                    "https://icweiliimg9.pstatp.com/weili/l/705631034798506015.jpg",
                    "https://weiliicimg6.pstatp.com/weili/l/1094780798674927662.webp",
                    "https://weiliicimg9.pstatp.com/weili/l/1094780807258308636.webp",
                    "https://icweiliimg1.pstatp.com/weili/l/1094780798668767287.jpg",
                    "https://weiliicimg1.pstatp.com/weili/l/1094780807258701825.jpg",
                    "https://weiliicimg6.pstatp.com/weili/l/1094780188783411233.jpg",
                    "https://icweiliimg9.pstatp.com/weili/l/1094780188783018030.jpg",
                    "https://weiliicimg6.pstatp.com/weili/l/1094780188783411261.jpg",
                    "https://weiliicimg1.pstatp.com/weili/l/1094780188789571586.jpg",
                    "https://weiliicimg6.pstatp.com/weili/l/1094780188789571627.webp",
                    "https://icweiliimg1.pstatp.com/weili/l/1094780188789571610.jpg",
                    "https://weiliicimg6.pstatp.com/weili/l/787628961277411354.webp",
                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fp6.itc.cn%2Fimages01%2F20201222%2F55665ca832474accbcb2e46cd49485c6.jpeg&refer=http%3A%2F%2Fp6.itc.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1614997427&t=51fabdc18e5dae9305f8070193e3bbea",
                    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=519577183,4160434227&fm=11&gp=0.jpg",
                    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3689618380,317517564&fm=26&gp=0.jpg",
                    "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2861472315,2534317377&fm=15&gp=0.jpg",
                    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=966250097,3901395641&fm=11&gp=0.jpg",
                    "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1277698822,4039166306&fm=11&gp=0.jpg",
                    "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2916035978,3012504481&fm=11&gp=0.jpg",
                    "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2491919677,2340363464&fm=26&gp=0.jpg",
                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fd.ifengimg.com%2Fw3840_h2160_q70%2Fimg1.ugc.ifeng.com%2Fnewugc%2F20200716%2F13%2Fwemedia%2F34a30d270fbef0c6158c2df6de69fa9b73c8903a_size513_w3840_h2160.jpg&refer=http%3A%2F%2Fd.ifengimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1614932191&t=fff412665a80a4dd4f034fb4d109a3af",
                    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=285763994,82342214&fm=11&gp=0.jpg",
                    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2481151912,1673996124&fm=11&gp=0.jpg",
                    "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1294726436,3322844368&fm=11&gp=0.jpg",
                    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=4234922280,260154011&fm=11&gp=0.jpg",
                    "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3591666507,3164792115&fm=11&gp=0.jpg",
                    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3990544123,320121360&fm=11&gp=0.jpg",
                    "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3877612850,684395128&fm=11&gp=0.jpg",
                    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2636911934,2232253283&fm=11&gp=0.jpg",
                    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1835342537,1409741570&fm=11&gp=0.jpg",
                    "https://user-gold-cdn.xitu.io/2020/4/28/171c03b0dae0a77a?imageView2/1/w/1304/h/734/q/85/format/webp/interlace/1",
                    "https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c3a497883c504bdab4430603e261c76e~tplv-k3u1fbpfcp-watermark.image",
                    "https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3ead398e1ca24004bcc5e409093512e1~tplv-k3u1fbpfcp-zoom-1.image",]
        }()
}
