////
////  ProfileViewController.swift
////  mini-project-iOS-bank-api-starter
////
////  Created by Ahmad Musallam on 06/03/2024.
////
//

import UIKit
import SnapKit

class ProfilePageViewController: UIViewController {
    
    
    // MARK: - Properties
    //var balance: AmountChange?
    var token: String?
    var userDetails: UserDetail?
    

    let inLogo = UIImageView()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profile")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()

    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .black
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let myDepositButton = UIButton(type: .system)
    
    let myWithdrawButton = UIButton(type: .system)
    
    let myTransactionsButton = UIButton(type: .system)


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ("Profile ")
        applyGradientBackground()
            
        fetchUser()
        setupUI()
        autoLayout()
      
        myDepositButton.addTarget(self, action: #selector(depositTapped), for: .touchUpInside)
        myWithdrawButton.addTarget(self, action: #selector(withdrawTapped), for: .touchUpInside)
        myTransactionsButton.addTarget(self, action: #selector(transactionList), for: .touchUpInside)
        
       
    }
    
    private func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()

        // Create the custom color with RGB values (255, 252, 240)
        let customColor = UIColor(red: 255/255, green: 252/255, blue: 240/255, alpha: 1.0)

        // Use the custom color and systemPurple in the gradient
        gradientLayer.colors = [customColor.cgColor, UIColor.systemMint.cgColor,UIColor.black]

        // Define the locations for the gradient stops
        gradientLayer.locations = [0.0, 4.0, 1.0]

        // Set the frame of the gradient layer to match the bounds of the view
        gradientLayer.frame = view.bounds

        // Insert the gradient layer at the bottom of the view's layer stack
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

 
    private func fetchUser() {
        NetworkManager.shared.fetchUser(token: token ?? "" ){ result in

                DispatchQueue.main.async {
                    switch result {

                    case .success(let details):
                        self.nameLabel.text = details.username
                        print("\( details.username)")
                        self.balanceLabel.text = String(details.balance)
                        self.emailLabel.text = details.email
                      



                    case .failure(let error ):
                        print(error)

                    }
                }

            }
        }
    
    
    func setupUI(){
   
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: view.topAnchor, paddingTop: 88,
                                width: 120, height: 120)
        profileImageView.layer.cornerRadius = 120 / 2
 
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
        
        view.addSubview(emailLabel)
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
        
        view.addSubview(balanceLabel)
        balanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        balanceLabel.anchor(top: emailLabel.bottomAnchor, paddingTop: 12)
        
        view.addSubview(myDepositButton)
        myDepositButton.setTitle("Deposit", for: .normal)
        view.addSubview(myWithdrawButton)
        myWithdrawButton.setTitle("Withdraw", for: .normal)
        view.addSubview(myTransactionsButton)
        myTransactionsButton.setTitle("Transaction History", for: .normal)
        
        view.addSubview(inLogo)
    }
    
    func autoLayout(){

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(120)
            make.height.equalTo(3000)
        }
        myDepositButton.backgroundColor = .lightGray
        myDepositButton.setTitleColor(.black, for: .normal)
        myDepositButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        myDepositButton.layer.cornerRadius = 10
        myDepositButton.layer.borderWidth = 0.5
        myDepositButton.layer.borderColor = UIColor.black.cgColor
        
        myDepositButton.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(55)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
        
        myWithdrawButton.backgroundColor = .lightGray
        myWithdrawButton.setTitleColor(.black, for: .normal)
        myWithdrawButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        myWithdrawButton.layer.cornerRadius = 10
        myWithdrawButton.layer.borderWidth = 0.5
        myWithdrawButton.layer.borderColor = UIColor.black.cgColor
        
        myWithdrawButton.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(55)
            make.trailing.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
        
        myTransactionsButton.backgroundColor = .lightGray
        myTransactionsButton.setTitleColor(.black, for: .normal)
        myTransactionsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        myTransactionsButton.layer.cornerRadius = 10
        myTransactionsButton.layer.borderWidth = 0.5
        myTransactionsButton.layer.borderColor = UIColor.black.cgColor
        
        myTransactionsButton.snp.makeConstraints { make in
            make.top.equalTo(myWithdrawButton.snp.bottom).offset(25)
            make.height.equalTo(50)
            make.width.equalTo(120)
            make.leading.trailing.equalToSuperview().inset(45)
            make.centerX.equalToSuperview()
            
            inLogo.image = UIImage(named: "logo")
            inLogo.snp.makeConstraints { make in
                        make.top.equalTo(myTransactionsButton.snp.bottom).offset(100)
                        make.centerX.equalToSuperview()
                        make.width.equalTo(200)
                        make.height.equalTo(150)
                    }
        }
    }
    func transactionButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "clock"), style: .plain, target: self, action: #selector(transactionList))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Selectors
    
    @objc func transactionList() {

        let transactionVC = TransactionViewController()
               
                transactionVC.token = token

                navigationController?.pushViewController(transactionVC, animated: true)
        
    }
    

    
    @objc func depositTapped(){
         let depositVC = DepositViewController()
        depositVC.modalPresentationStyle = .popover
        depositVC.token = token
         self.present(depositVC, animated: true)
     }
    @objc func withdrawTapped(){
         let withdrawVC = WithdrawViewController()
        withdrawVC.modalPresentationStyle = .popover
        withdrawVC.token = token
        self.present(withdrawVC, animated: true)
        
     }
    
   

}
    extension UIColor {
        static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
            return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        }
        
        static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
    }

    extension UIView {
        
        func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
                    paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
            }
            
            if let left = left {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
            }
            
            if let bottom = bottom {
                if let paddingBottom = paddingBottom {
                    bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
                }
            }
            
            if let right = right {
                if let paddingRight = paddingRight {
                    rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
                }
            }
            
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }



//
//
//
//import UIKit
//import SnapKit
//
//class ProfilePageViewController: UIViewController {
//
//
//    // MARK: - Properties
//    //var balance: AmountChange?
//    var token: String?
//    var userDetails: UserDetail?
//
////    lazy var containerView: UIView = {
////        let view = UIView()
////        view.backgroundColor = .purple
////
////        view.addSubview(profileImageView)
////        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
////        profileImageView.anchor(top: view.topAnchor, paddingTop: 88,
////                                width: 120, height: 120)
////        profileImageView.layer.cornerRadius = 120 / 2
////
////        view.addSubview(nameLabel)
////        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
////        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
////
////        view.addSubview(emailLabel)
////        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
////        emailLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
////
////        view.addSubview(balanceLabel)
////        balanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
////        balanceLabel.anchor(top: emailLabel.bottomAnchor, paddingTop: 12)
////
////        return view
////    }()
//
//    let profileImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.image = UIImage(named: "profile")
//        iv.contentMode = .scaleAspectFill
//        iv.clipsToBounds = true
//        iv.layer.borderWidth = 3
//        iv.layer.borderColor = UIColor.white.cgColor
//        return iv
//    }()
//
//
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = UIFont.boldSystemFont(ofSize: 26)
//        label.textColor = .white
//        return label
//    }()
//
//    let emailLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .white
//        return label
//    }()
//
//
//    let balanceLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textColor = .white
//        return label
//    }()
//
//    let myDepositButton = UIButton(type: .system)
//
//    let myWithdrawButton = UIButton(type: .system)
//
//    let myTransactionsButton = UIButton(type: .system)
//
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .blue
//
//        fetchUser()
//        setupUI()
//        autoLayout()
//
//        myDepositButton.addTarget(self, action: #selector(depositTapped), for: .touchUpInside)
//        myWithdrawButton.addTarget(self, action: #selector(withdrawTapped), for: .touchUpInside)
//        myTransactionsButton.addTarget(self, action: #selector(transactionList), for: .touchUpInside)
//
//       // messageButton.addTarget(ProfilePageViewController.self, action: #selector(transactionList), for: .touchUpInside)
//
//        //fetchUser()
//    }
//
//
//   // getAdccountDetails(token: token ?? "")
//    private func fetchUser() {
//        NetworkManager.shared.fetchUser(token: token ?? "" ){ result in
//
//                DispatchQueue.main.async {
//                    switch result {
//
//                    case .success(let details):
//                        self.nameLabel.text = details.username
//                        print("\( details.username)")
//                        self.balanceLabel.text = String(details.balance)
//                        self.emailLabel.text = details.email
//                        //self.idLabel.text = String(details.id)
//
//
//
//                    case .failure(let error ):
//                        print(error)
//
//                    }
//                }
//
//            }
//        }
//
//
//    func setupUI(){
//       // view.addSubview(containerView)
//        view.addSubview(profileImageView)
//        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        profileImageView.anchor(top: view.topAnchor, paddingTop: 88,
//                                width: 120, height: 120)
//        profileImageView.layer.cornerRadius = 120 / 2
//
//        view.addSubview(nameLabel)
//        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
//
//        view.addSubview(emailLabel)
//        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        emailLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
//
//        view.addSubview(balanceLabel)
//        balanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        balanceLabel.anchor(top: emailLabel.bottomAnchor, paddingTop: 12)
//
//        view.addSubview(myDepositButton)
//        myDepositButton.setTitle("Deposit", for: .normal)
//        view.addSubview(myWithdrawButton)
//        myWithdrawButton.setTitle("Withdraw", for: .normal)
//        view.addSubview(myTransactionsButton)
//        myTransactionsButton.setTitle("Transaction History", for: .normal)
//    }
//
//    func autoLayout(){
////        containerView.anchor(top: view.topAnchor, left: view.leftAnchor,
////                             right: view.rightAnchor, height: 350)
//        myDepositButton.backgroundColor = .purple
//        myDepositButton.setTitleColor(.white, for: .normal)
//        myDepositButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        myDepositButton.layer.cornerRadius = 10
//        myDepositButton.layer.borderWidth = 0.5
//        myDepositButton.layer.borderColor = UIColor.black.cgColor
//
//        myDepositButton.snp.makeConstraints { make in
//            make.top.equalTo(balanceLabel.snp.bottom).offset(55)
//            make.leading.equalToSuperview().inset(50)
//            make.height.equalTo(50)
//            make.width.equalTo(120)
//        }
//
//        myWithdrawButton.backgroundColor = .purple
//        myWithdrawButton.setTitleColor(.white, for: .normal)
//        myWithdrawButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        myWithdrawButton.layer.cornerRadius = 10
//        myWithdrawButton.layer.borderWidth = 0.5
//        myWithdrawButton.layer.borderColor = UIColor.black.cgColor
//
//        myWithdrawButton.snp.makeConstraints { make in
//            make.top.equalTo(balanceLabel.snp.bottom).offset(55)
//            make.trailing.equalToSuperview().inset(50)
//            make.height.equalTo(50)
//            make.width.equalTo(120)
//        }
//
//        myTransactionsButton.backgroundColor = .purple
//        myTransactionsButton.setTitleColor(.white, for: .normal)
//        myTransactionsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        myTransactionsButton.layer.cornerRadius = 10
//        myTransactionsButton.layer.borderWidth = 0.5
//        myTransactionsButton.layer.borderColor = UIColor.black.cgColor
//
//        myTransactionsButton.snp.makeConstraints { make in
//            make.top.equalTo(myWithdrawButton.snp.bottom).offset(25)
//            make.height.equalTo(50)
//            make.width.equalTo(120)
//            make.leading.trailing.equalToSuperview().inset(45)
//            make.centerX.equalToSuperview()
//
//
//        }
//    }
//    func transactionButton(){
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "clock"), style: .plain, target: self, action: #selector(transactionList))
//        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
//    }
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//
//    // MARK: - Selectors
//
//    @objc func transactionList() {
////        let transactionVC = TransactionViewController()
////      // transactionVC.modalPresentationStyle = .popover
////       transactionVC.token = token
////        self.present(transactionVC, animated: true)
//        let transactionVC = TransactionViewController()
//
//                transactionVC.token = token
//
//                navigationController?.pushViewController(transactionVC, animated: true)
//
//    }
//
//
//
//    @objc func depositTapped(){
//         let depositVC = DepositViewController()
//        depositVC.modalPresentationStyle = .popover
//        depositVC.token = token
//         self.present(depositVC, animated: true)
//     }
//    @objc func withdrawTapped(){
//         let withdrawVC = WithdrawViewController()
//        withdrawVC.modalPresentationStyle = .popover
//        withdrawVC.token = token
//        self.present(withdrawVC, animated: true)
//
//     }
//
//
//
//}
//    extension UIColor {
//        static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
//            return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
//        }
//
//        static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
//    }
//
//    extension UIView {
//
//        func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
//                    paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
//
//            translatesAutoresizingMaskIntoConstraints = false
//
//            if let top = top {
//                topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
//            }
//
//            if let left = left {
//                leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
//            }
//
//            if let bottom = bottom {
//                if let paddingBottom = paddingBottom {
//                    bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
//                }
//            }
//
//            if let right = right {
//                if let paddingRight = paddingRight {
//                    rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
//                }
//            }
//
//            if let width = width {
//                widthAnchor.constraint(equalToConstant: width).isActive = true
//            }
//
//            if let height = height {
//                heightAnchor.constraint(equalToConstant: height).isActive = true
//            }
//        }
//    }
