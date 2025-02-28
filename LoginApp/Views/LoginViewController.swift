//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Mohammad Khan on 28/02/25.
//
import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let submitButton = UIButton()
    
    private let disposeBag = DisposeBag()
    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .white
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Enter Email"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.isSecureTextEntry = true
        submitButton.setTitle("Submit", for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.backgroundColor = .purple
        submitButton.isEnabled = false

        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, submitButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func bindViewModel() {
        emailTextField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        
        viewModel.isFormValid
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)

        submitButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigateToHomeScreen()
            })
            .disposed(by: disposeBag)
    }

    private func navigateToHomeScreen() {
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}
