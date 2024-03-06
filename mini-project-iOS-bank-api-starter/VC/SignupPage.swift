//
//  ViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import UIKit
import Eureka

class SignupViewController: FormViewController {
    
    enum TagUser: String {
        case username = "username"
        case email = "email"
        case password = "password"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupForm()
    }
    
    private func setupForm() {
        form +++ Section("Signup Information")
        <<< TextRow() { row in
            row.title = "Username"
            row.placeholder = "Enter username"
            row.tag = TagUser.username.rawValue
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< EmailRow() { row in
            row.title = "Email"
            row.placeholder = "Enter email"
            row.tag = TagUser.email.rawValue
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< PasswordRow() { row in
            row.title = "Password"
            row.placeholder = "Enter password"
            row.tag = TagUser.password.rawValue
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        +++ Section()
        <<< ButtonRow() { row in
            row.title = "Sign Up"
            row.onCellSelection { cell, row in
                self.signUpAction()
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(signUpAction))
    }
    
    @objc func signUpAction() {
        let errors = form.validate()
        guard errors.isEmpty else {
            print("Error, something is missing! 😡")
            presentAlertWithTitle(title: "Error", message: "Error, something is missing! 😡")
            return
        }
        
        let userNameRow: TextRow? = form.rowBy(tag: TagUser.username.rawValue)
        let emailRow: EmailRow? = form.rowBy(tag: TagUser.email.rawValue)
        let passwordRow: PasswordRow? = form.rowBy(tag: TagUser.password.rawValue)
        
        let username = userNameRow?.value ?? ""
        let email = emailRow?.value ?? ""
        let password = passwordRow?.value ?? ""
        
        let user = User(username: username, email: email, password: password)
        
        NetworkManager.shared.signup(user: user) { success in
            DispatchQueue.main.async {
                switch success {
                case .success(let tokenResponse):
                    print("Sign up successful. Token: \(tokenResponse.token)")

                    
                    //Nav
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
