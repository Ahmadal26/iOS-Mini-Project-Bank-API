//
//  WithdrawViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Ahmad Musallam on 06/03/2024.
//
//


import UIKit
import Eureka

class WithdrawViewController: FormViewController {
    var token: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = ("Withdraw")
        setupForm()
    }
    
    
    private func setupForm(){
        form +++ Section("Withdrawal")
        <<< DecimalRow() { row in
            row.title = "Withdraw Amount"
            row.placeholder = "Enter amount to withdraw"
            row.tag = "withdraw"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        
        form +++ Section()
        <<< ButtonRow(){ row in
            row.title = "Withdraw"
            row.onCellSelection{cell, row in
                self.submitTapped()
            }
        }
    }
    @objc func submitTapped() {
        let withdrawRow: DecimalRow? = form.rowBy(tag: "withdraw")
  
        if let withdrawAmount = withdrawRow?.value {
          let withdraws = AmountChange(amount: withdrawAmount)

          NetworkManager.shared.withdraw(token: token ?? "", amountChange: withdraws) { result in
            switch result {
            case .success(let updatedBalance):
                print("Withdraw successful. New balance: \(updatedBalance)")
                          // Update your local balance variable or UI element here using updatedBalance
            case .failure(let error):
                print("Withdraw failed: \(error.localizedDescription)")
            }
          }
        } else {
          print("Withdraw amount not available")
        }
        
        let errors = form.validate()
        guard errors.isEmpty else {
            print(errors)
            presentAlertWithTitle(title: "Error", message: "Please enter a valid number")
            return
        }
        
        let token = TokenResponse(token: "\(TokenResponse.init(token: ""))")
    }
    
    private func presentAlertWithTitle(title: String, message: String, completionHandler: (() -> Void)? = nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { _ in
                completionHandler?()
            })
            self.present(alert, animated: true, completion: nil)
        }
}
