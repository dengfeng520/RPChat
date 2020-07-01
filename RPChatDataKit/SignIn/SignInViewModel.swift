//
//  SignInViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/6/16.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import RxSwift
import RxCocoa

public class SignInViewModel: NSObject {
    
    public let inputStuNum = BehaviorSubject<String>(value: "")
    public let inputStuNumEnabled = BehaviorSubject<Bool>(value: true)
        
    public let inputPassWord = BehaviorSubject<String>(value: "")
    public let inputPassWordEnabled = BehaviorSubject<Bool>(value: true)
        
    public let signInButtonTapped = PublishSubject<Void>()
            
    public let bag = DisposeBag()
        
    public let error : PublishSubject<String> = PublishSubject()
    public let signInSuccess: PublishSubject<String> = PublishSubject()
    
    //
    public lazy var signInButtonEnabled =
    Observable.combineLatest(
        inputStuNum.asObservable(),
        inputStuNumEnabled.asObservable(),
        inputPassWord.asObservable(),
        inputPassWordEnabled.asObservable()) {
        (e: String, es: Bool, p: String, ps: Bool) -> Bool in
            return (e.count >= 6 && p.count > 6 && !e.isEmpty && !p.isEmpty && es && ps)
    }.share()
        
    public override init() {
        super.init()
            
        signInButtonTapped.asObservable().subscribe(onNext: {
            [weak self] in
            guard let `self` = self else { return }
            self.clickSignIn()
        }).disposed(by: bag)
    }
        
    func fetchStuNumAndPassword() -> (String, String) {
        do {
        let stuNum = try inputStuNum.value()
        let password = try inputPassWord.value()
            
        return (stuNum, password)
        }
        catch {
            fatalError("Failed reading stuNum and password from behavior subjects.")
        }
    }
        
        private func clickSignIn() {
            //(stuNum, password)
    //  let data = fetchStuNumAndPassword()
            
    HTTPRequest().requestWithMap(signinRequest(parameter: [:])) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let returnJson) :
            if returnJson["returnCode"].intValue == 601 || returnJson["returnCode"].intValue == 201 {
                self.error.onNext(returnJson["returnMsg"].stringValue)
            } else {
                self.signInSuccess.onNext(returnJson["returnMsg"].stringValue)
            }
                break
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self.error.onNext("请求服务器错误")
                    break
                case .authorizationError(let errorJson):
                    self.error.onNext(errorJson["returnMsg"].stringValue)
                    break
                case .statusCodeError(let errorJson):
                    self.error.onNext(errorJson["returnMsg"].stringValue)
                    break
                case .serverError:
                    self.error.onNext("连接服务器错误请重试")
                    break
                case .isAlert(let errorJson):
                    self.error.onNext(errorJson["returnMsg"].stringValue)
                    break
                default :
                self.error.onNext("连接服务器错误请重试")
                break
                }
            }
        }
    }
        
    func indicateSigningIn() {
        inputStuNumEnabled.onNext(false)
        inputPassWordEnabled.onNext(false)
    }
        
    func indicateSignInError(_ error: Error) {
        inputStuNumEnabled.onNext(true)
        inputPassWordEnabled.onNext(true)
    }
        
//    open class func configKeyBoard() {
//        let manager = IQKeyboardManager.shared
//        manager.enable = true
//        manager.shouldResignOnTouchOutside = true
//        manager.shouldToolbarUsesTextFieldTintColor = true
//        manager.enableAutoToolbar = false
//        manager.shouldShowToolbarPlaceholder = false
//        manager.toolbarManageBehaviour = .byTag
//    }
}
