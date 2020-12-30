//
//  SignInViewModel.swift
//  RPChatDataKit
//
//  Created by rp.wang on 2020/6/16.
//  Copyright © 2020 Beijing Physical Fitness Sport Science and Technology Co.,Ltd. All rights reserved.
//

import RxSwift

public class SignInViewModel: PublicViewModel {
    
    public let inputStuNum = BehaviorSubject<String>(value: "")
    public let inputStuNumEnabled = BehaviorSubject<Bool>(value: true)
    
    public let inputPassWord = BehaviorSubject<String>(value: "")
    public let inputPassWordEnabled = BehaviorSubject<Bool>(value: true)
    
    public let signInButtonTapped = PublishSubject<Void>()
    
    public lazy var signInButtonEnabled = Observable.combineLatest( inputStuNum.asObservable(),
                                                                    inputStuNumEnabled.asObservable(),
                                                                    inputPassWord.asObservable(),
                                                                    inputPassWordEnabled.asObservable()) {
        (e: String, es: Bool, p: String, ps: Bool) -> Bool in
        return (e.count >= 6 && p.count >= 6 && !e.isEmpty && !p.isEmpty && es && ps)
    }.share()
    
    public override init() {
        super.init()
        
        signInButtonTapped.asObservable().subscribe(onNext: {
            [weak self] in
            guard let `self` = self else { return }
            self.clickSignIn()
        }).disposed(by: disposeBag)
    }
    
    // 点击登录之后获取用户名和密码的方法
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
    
    // 点击登录按钮和 服务器交互
    private func clickSignIn() {
        let data = fetchStuNumAndPassword()
        let pwd = ConfigAES().encryptStringWith(strToEncode: data.1)
        let path = __apiFetchSignIn + "?username=\(data.0)&password=\(pwd)&grant_type=password"
        
        loading.onNext(true)
        RPAuthRemoteAPI().requestData(SigninRequest(parameter: [:], path: path))
            .subscribe(onNext: { returnJson in
                print("取得 json 成功: \(returnJson)")
                self.successSubject.onNext(returnJson["returnMsg"].stringValue)
            }, onError: { errorJson in
                print("取得 json 失败 Error: \(errorJson.localizedDescription)")
                self.error.onNext(errorJson.localizedDescription)
                self.loading.onNext(false)
            }, onCompleted: {
                print("取得 json 任务成功完成")
                self.loading.onNext(false)
            }).disposed(by: disposeBag)
    }
    
    // 登录成功后 禁用UITextFile输入
    func indicateSigningIn() {
        inputStuNumEnabled.onNext(false)
        inputPassWordEnabled.onNext(false)
    }
    // 登录失败时 重置
    func indicateSignInError(_ error: Error) {
        inputStuNumEnabled.onNext(true)
        inputPassWordEnabled.onNext(true)
    }
}
