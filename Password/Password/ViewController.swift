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
    var alert: UIAlertController?
    
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
        resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
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
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 4),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 4)
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
        setupKeyboardHiding()
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
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true) // resign first responder
    }
    
    @objc func resetPasswordButtonTapped(sender: UIButton) {
        view.endEditing(true)
        
        let isValidNewPassword = newPasswordTextField.validate()
        let isValidConfirmPassword = confirmPasswordTextField.validate()
        
        if isValidNewPassword && isValidConfirmPassword {
            showAlert(title: "Success", message: "You have successfully changed your password.")
        }
    }
    
    private func showAlert(title: String, message: String) {
        alert =  UIAlertController(title: "", message: "", preferredStyle: .alert)
        guard let alert = alert else { return }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        alert.title = title
        alert.message = message
        present(alert, animated: true, completion: nil)
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

// MARK: Keyboard
extension ViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        //view.frame.origin.y = view.frame.origin.y - 200
        
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        //print("foo - userInfo: \(userInfo)")
        //print("foo - keyboardFrame: \(keyboardFrame)")
        //print("foo - currentTextField: \(currentTextField)")
        
        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            // adjust view up
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }

        //print("foo - currentTextFieldFrame: \(currentTextField.frame)")
        //print("foo - convertedTextFieldFrame: \(convertedTextFieldFrame)")
        
        
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }

    /// Finds the current first responder
    /// - Returns: the current UIResponder if it exists
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}

// MARK: Tests
extension ViewController {
    var newPasswordText: String? {
        get { return newPasswordTextField.text }
        set { newPasswordTextField.text = newValue}
    }
    
    var confirmPasswordText: String? {
        get { return confirmPasswordTextField.text }
        set { confirmPasswordTextField.text = newValue}
    }
}
