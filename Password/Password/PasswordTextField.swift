//
//  PasswordTextField.swift
//  Password
//
//  Created by David Ruiz on 4/01/23.
//

import UIKit

class PasswordTextField: UIView {
    
    // UI Elements
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let textField = UITextField()
    let eyeButton = UIButton(type: .custom)
    let divider = UIView()
    let errorLabel = UILabel()
    
    // Auxiliar
    let placeHolderText: String
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
         
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }
}

// MARK: Style and Layout
extension PasswordTextField {
    
    func style() {
        backgroundColor = .tertiarySystemBackground
        
        // Lock Image
        lockImageView.contentMode = .scaleAspectFit
        
        // Test Field
        textField.isSecureTextEntry = true
        textField.placeholder = placeHolderText
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        //textField.delegate = self
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        
        // Eye button
        eyeButton.contentMode = .scaleAspectFit
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(tooglePasswordView), for: .touchUpInside)
        
        // Divider
        divider.backgroundColor = .separator
        
        // Error label
        errorLabel.textColor = .systemRed
        errorLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        errorLabel.text = "Your password must meet the requirements below. Long text, lost of words that are not needed."
        errorLabel.isHidden = false
        errorLabel.adjustsFontSizeToFitWidth = false
        errorLabel.minimumScaleFactor = 0.8
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
    
    }
    
    func layout() {
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(divider)
        addSubview(errorLabel)
        
        // Lock Image
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        // Test Field
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1)
        ])
        
        //Eye Button
        NSLayoutConstraint.activate([
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // CHCR
        lockImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // Divider
        NSLayoutConstraint.activate([
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1)
        ])
        
        // Error Label
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: divider.bottomAnchor, multiplier: 1),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalToSystemSpacingBelow: errorLabel.bottomAnchor, multiplier: 1)
        ])
    
    }
}

// MARK: Funtionality
extension PasswordTextField {
    @objc func tooglePasswordView(){
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
}
