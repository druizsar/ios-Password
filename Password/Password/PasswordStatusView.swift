//
//  PasswordStatusView.swift
//  Password
//
//  Created by David Ruiz on 10/01/23.
//

import UIKit

class PasswordStatusView: UIView {
    
    // UI Elements
    let stackView = UIStackView()
    let lengthCriteriaView = PasswordCriteriaView(text: "Length 8-32 characters (No spaces).")
    let uppercaseCriteriaView = PasswordCriteriaView(text: "Has uppercase letter (A-Z).")
    let lowerCaseCriteriaView = PasswordCriteriaView(text: "Has lowercase letter (a-z).")
    let digitCriteriaView = PasswordCriteriaView(text: "Has digit (0-9).")
    let specialCharacterCriteriaView = PasswordCriteriaView(text: "Has special character (e.g. !@#$%^).")
    let criteriaLabel = UILabel()
    
    // Aux
    var shouldResetCriteria = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
}

// MARK: Style and Layout
extension PasswordStatusView {
    
    private func style() {
        backgroundColor = .tertiarySystemFill
        
        // Stack View
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        
        // Criteria label
        criteriaLabel.numberOfLines = 0
        criteriaLabel.lineBreakMode = .byWordWrapping
        criteriaLabel.attributedText = makeCriteriaMessage()
    }
    
    private func layout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        lengthCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        uppercaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        lowerCaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        digitCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        criteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(uppercaseCriteriaView)
        stackView.addArrangedSubview(lowerCaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterCriteriaView)
        
        // Stack View
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
    }
    
}

// MARK: Extra style functions
extension PasswordStatusView {
 
    private func makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)

        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))

        return attrText
    }
}

// MARK: Functionality
extension PasswordStatusView {
    func updateDisplay(_ text: String) {
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        if shouldResetCriteria {
            lengthAndNoSpaceMet ? lengthCriteriaView.isCriteriaMet = true : lengthCriteriaView.reset()
            uppercaseMet ? uppercaseCriteriaView.isCriteriaMet = true : uppercaseCriteriaView.reset()
            lowercaseMet ? lowerCaseCriteriaView.isCriteriaMet = true : lowerCaseCriteriaView.reset()
            digitMet ? digitCriteriaView.isCriteriaMet = true : digitCriteriaView.reset()
            specialCharacterMet ? specialCharacterCriteriaView.isCriteriaMet = true : specialCharacterCriteriaView.reset()
        } else {
            lengthCriteriaView.isCriteriaMet = lengthAndNoSpaceMet
            uppercaseCriteriaView.isCriteriaMet = uppercaseMet
            lowerCaseCriteriaView.isCriteriaMet = lowercaseMet
            digitCriteriaView.isCriteriaMet = digitMet
            specialCharacterCriteriaView.isCriteriaMet = specialCharacterMet
        }
        
    }
    
    func validate(_ text: String) -> Bool {
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)

        let criteriaSum = uppercaseMet.IntValue + lowercaseMet.IntValue + digitMet.IntValue + specialCharacterMet.IntValue
        
        if criteriaSum >= 3 && PasswordCriteria.lengthAndNoSpaceMet(text) {
            return true
        } else {
            return false
        }
    }
    
    func reset() {
        lengthCriteriaView.reset()
        uppercaseCriteriaView.reset()
        lowerCaseCriteriaView.reset()
        digitCriteriaView.reset()
        specialCharacterCriteriaView.reset()
    }
}


// MARK: Bool extension
extension Bool {
    var IntValue: Int {
        return self ? 1 : 0
    }
}

// MARK: Tests
extension PasswordCriteriaView {
    var isCheckMarkImage: Bool {
        return imageView.image == checkmarkImage
    }

    var isXmarkImage: Bool {
        return imageView.image == xmarkImage
    }

    var isResetImage: Bool {
        return imageView.image == circleImage
    }
}
