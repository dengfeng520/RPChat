<h3><center>基于MVVM构建聊天App</center></h3>

<h6 align='right'>小时光</h6>
<h6  align='right'>北京体适能体育科技有限公司</h6> 

![](https://img.shields.io/badge/language-swift-orange.svg)
![](https://img.shields.io/cocoapods/l/RPBannerView-Swift.svg?style=flat)

一个简单的聊天demo，目前正在更新中，已经实现的思路和界面展示请点击[RPChat Wiki](https://github.com/dengfeng520/RPChat/wiki/%E5%9F%BA%E4%BA%8EMVVM%E6%9E%84%E5%BB%BA%E8%81%8A%E5%A4%A9App)

<h3>1、如何让代码跑起来</h3>

（1）、打开 terminal

```
cd Desktop/
git clone https://github.com/dengfeng520/RPChat.git
```
（2）、下载完成后

```
cd RPChat 
carthage update --platform iOS --no-use-binaries
```
如果在update时报错，请查找[Github Carthage](https://github.com/Carthage/Carthage)

（3）、添加第三方framework

* 更新完成后，打开工程，选择TARGETS -->Build Phases--> Link Binary With Libries 点击加号，选择 Add File --> Carthage --> Build --> iOS 添加所需的FrameWork
* 在Input Files中引入要用到的第三方库路径，格式为：

```
$(SRCROOT)/Carthage/Build/iOS/***.framework
```
（4）、command + R  运行

<h3>2、工程结构介绍</h3>

* **RPChat_iOS.framework** 是和UI的显示以及交互相关的代码
* **RPChatUIKit.framework**是整个项目中会用到的对UIKit的公共扩展
* **RPChatDataKit.framework**是整个项目的数据存储以及访问接口，也可以理解为是App的View Model以及Model
* **RPKeychain.framework**对Keychain的封装
* **RPChatUnitTests**单元测试相关代码

<h3>3、用到的第三方开源库</h3>

* Alamofire
* RxSwift
* Kingfisher
* MJRefresh
* CocoaAsyncSocket
* CryptoSwift
* SwiftyRSA

<h3>4、自己封装的开源库</h3>

* **[RPToastView](https://github.com/dengfeng520/RPToastView)一个简单的LoadingView**
* **[RPBannerView-Swift](https://github.com/dengfeng520/RPBannerView-Swift)一个轻量级的Banner提示框**
* **[RPAutoLayout](https://github.com/dengfeng520/RPAutoLayout)**对系统的**NSLayoutAnchor**做简单的封装
