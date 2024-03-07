//
//  TransactionViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nada Alshaibani on 07/03/2024.
//

import UIKit
import Alamofire

class TransactionViewController: UITableViewController {
    var token: String?
    var transactions: [Transaction] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchTransaction()
        title = ("Transaction List")
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        
        let transaction = transactions[indexPath.row]
        
        cell.textLabel?.text = "\(transaction.type)"
        //cell.imageView?.image = UIImage(named: "deposit")
        if transaction.type == "deposit" {
            cell.imageView?.image = UIImage(named: "deposit")
        } else {
            cell.imageView?.image = UIImage(named: "withdraw")
        }
        cell.textLabel?.numberOfLines = 3
        cell.detailTextLabel?.text = " \(transaction.amount)KWD"
        cell.detailTextLabel?.textColor = transaction.type == "deposit" ? #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1) : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return cell
        
    }
    
    func fetchTransaction(){
        guard let token = token else {
            print("Token is missing")
            return
        }
        NetworkManager.shared.fetchTransactions(token: token) { result in
            switch result {
          
            case .success(let transactions):
                print("successful transaction \(transactions)")
            
                self.transactions = transactions
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed: \(error)")
               
            }
        }
    }

}
