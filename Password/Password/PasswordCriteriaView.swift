//
//  PasswordCriteriaView.swift
//  Password
//
//  Created by David Ruiz on 5/01/23.
//

import UIKit

class PasswordCriteriaView: UIView {
    
    // UI Elements
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    // Aux Images
    let checkmarkImage = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let xmarkImage = UIImage(systemName: "xmark.circle")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let circleImage = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
    
    // Image setting functionality
    var isCtireriaMet: Bool = false {
        didSet {
            if isCtireriaMet {
                imageView.image = checkmarkImage
            } else {
                imageView.image = xmarkImage
            }
        }
    }
    
    func reset(){
        isCtireriaMet = false
        imageView.image = circleImage
    }
    
    init(text: String) {
        super.init(frame: .zero)
        
        label.text = text
        
        style()
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 40)
    }
    
}

// MARK: Style and Layout
extension PasswordCriteriaView {
    
    private func style() {
        
        // Stack View
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.backgroundColor = .secondarySystemBackground
        
        // Image View
        imageView.image = circleImage
        imageView.contentMode = .scaleAspectFit
        
        // Label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
    }
    
    private func layout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        
        // Stack View
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // CHCR
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
}

// MARK: Functionality
extension PasswordCriteriaView {
    
}
