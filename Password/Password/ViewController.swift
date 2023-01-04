//
//  ViewController.swift
//  Password
//
//  Created by David Ruiz on 4/01/23.
//

import UIKit

class ViewController: UIViewController {

    // UI Elements
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
    
    func style() {
        
    }
    
    func layout() {
        view.addSubview(newPasswordTextField)
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
