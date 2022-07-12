//
//  ViewController.swift
//  LoginRx
//
//  Created by musk on 7/10/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    private let bag = DisposeBag()

    let vm = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let inputs = LoginViewModel.Input(username: self.usernameTF.rx.text, password: self.passwordTF.rx.text, loginButtonClick: self.loginButton.rx.tap)
        let ouputs = vm.transform(input: inputs)
        ouputs.isLoginButtonEnable.debug("v1", trimOutput: false).drive(self.loginButton.rx.valid).disposed(by: bag)
        ouputs.isLoginButtonEnable.debug("v1", trimOutput: false).drive(self.loginButton.rx.valid).disposed(by: bag)

        
    }
    @IBAction func CT(_ sender: Any) {
//        not working
        self.usernameTF.text = "111"
        self.passwordTF.text = "222"

//        also not working
//        self.usernameTF.rx.text.onNext("1111")
//        self.passwordTF.rx.text.onNext("3333")
    }
    

}


extension Reactive where Base : UIButton {
   public var valid : Binder<Bool> {
        return Binder(self.base) { button, valid in
            button.isEnabled = valid
            button.backgroundColor = valid ? .green : .gray
        
        }
    }
}
