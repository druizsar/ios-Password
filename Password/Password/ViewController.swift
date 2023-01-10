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
    let passwordStatusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Confirm your password")
    let resetButton = UIButton(type: .system)
    
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
        
        // Status view
        passwordStatusView.layer.cornerRadius = 10
        passwordStatusView.clipsToBounds = true
        
        // Reset button
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset Password", for: [])
        // resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordStatusView.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(passwordStatusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        view.addSubview(resetButton)
        
        // Stack View
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 4)
        ])
        
        // Button
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 3),
            resetButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: resetButton.trailingAnchor, multiplier: 4)
        ])
    }
}
