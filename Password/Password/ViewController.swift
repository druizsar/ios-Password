//
//  ViewController.swift
//  Password
//
//  Created by David Ruiz on 4/01/23.
//

import UIKit

class ViewController: UIViewController {

    // UI Elements
    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
    let passwordCriteriaView = PasswordCriteriaView(text: "Contains at least one uppercase letter (A-Z).")
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Confirm your password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
    
    func style() {
        
        // Stack view
        stackView.axis = .vertical
        stackView.spacing = 16
    }
    
    func layout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(passwordCriteriaView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        
        // Stack View
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 4)
        ])
    }
}
