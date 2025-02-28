//
//  LoginViewModel.swift
//  LoginApp
//
//  Created by Mohammad Khan on 28/02/25.
//
import RxSwift
import RxCocoa
import Foundation

class LoginViewModel {
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    var isFormValid: Observable<Bool> {
        return Observable.combineLatest(email, password)
            .map { email, password in
                return self.isValidEmail(email) && self.isValidPassword(password)
            }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8 && password.count <= 15
    }
}
