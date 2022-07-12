//
//  LoginViewModel.swift
//  LoginRx
//
//  Created by musk on 7/10/22.
//

import Foundation
import RxCocoa
import RxSwift

//protocol ViewModelType: AnyObject {
//    associatedtype Input
//    associatedtype Output
//
//    var input: Input { get }
//    var output: Output { get }
//}
protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}

class LoginViewModel: ViewModelType {
    
    struct Input {
        let username: ControlProperty<String?>
        let password: ControlProperty<String?>
        let loginButtonClick: ControlEvent<Void>
    }
    
    struct Output {
        let isLoginButtonEnable: Driver<Bool>
        let loginResult: Driver<(res: Bool, model: Any, msg: String?)?>
    }
    
    func transform(input: Input) -> Output {
        let isEnable = Observable.combineLatest(input.username, input.password) { u, p in
            return u?.isEmpty == false && p?.isEmpty == false
        }.asDriver(onErrorJustReturn: false)
        
        let userInputs = Observable.combineLatest(input.username, input.password)
        let loginResult = input.loginButtonClick.withLatestFrom(userInputs).flatMap { (username, pasword)  in
            return self.login(username: username, password: pasword)
        }.asDriver(onErrorJustReturn: nil)
        return Output(isLoginButtonEnable: isEnable, loginResult: loginResult)
        
    }
    
    
    func login(username: String?, password: String?) -> Driver<(res: Bool, model: Any, msg: String?)?>{
            return Observable<(res: Bool, model: Any, msg: String?)?>.create{ (observer) -> Disposable in
                    observer.onNext((res: true, model: "sssss", msg: nil))
                    observer.onCompleted()
                    return Disposables.create{}
            }.asDriver(onErrorJustReturn: (res: false, model: "", msg: "xxx"))
        }

}
