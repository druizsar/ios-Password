//
//  ViewController.swift
//  Password
//
//  Created by David Ruiz on 4/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    // Alias
    typealias CustomValidation = PasswordTextField.CustomValidation

    // UI Elements
    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
    let passwordStatusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Confirm your password")
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        funtionality()
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

// MARK: Funtionality
extension ViewController {
    
    func funtionality() {
        // Delegates
        newPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    func setup(){
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
    }
    
    private func setupNewPassword() {
        let newPasswordValidation: CustomValidation = { text in
            // Empty text
            guard let text = text, !text.isEmpty else {
                self.passwordStatusView.reset()
                return (false, "Enter your password")
            }
            
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!*()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.passwordStatusView.reset()
                return (false, "Enter valid special chars (.,@:?!()*$\\/#) with no spaces")
            }
            
            // Criteria met
            self.passwordStatusView.updateDisplay(text)
            if !self.passwordStatusView.validate(text) {
                return (false, "Your password must meet the requirements below")
            }
            
            return (true, "")
        }
        newPasswordTextField.customValidation = newPasswordValidation
    }
    
    private func setupConfirmPassword(){
        let confirmPasswordValidation: CustomValidation = { text in
            // Empty text
            guard let text = text, !text.isEmpty else {
                self.passwordStatusView.reset()
                return (false, "Enter your password")
            }
            
            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match")
            }
            return (true, "")
        }
        
        confirmPasswordTextField.customValidation = confirmPasswordValidation
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true) // resign first responder
    }
    
}

// MARK: PasswordTextFieldDelegate
extension ViewController: PasswordTextFieldDelegate {
    
    func editingChanged(_ sender: PasswordTextField) {
        if sender == newPasswordTextField {
            passwordStatusView.updateDisplay(sender.textField.text ?? "")
        }
        
        if sender == confirmPasswordTextField {
            
        }
    }
    
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender == newPasswordTextField {
            passwordStatusView.shouldResetCriteria = false
            _ = newPasswordTextField.validate()
        }
        
        if sender == confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
    
}
