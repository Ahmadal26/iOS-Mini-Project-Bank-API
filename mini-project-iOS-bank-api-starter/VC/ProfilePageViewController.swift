//
//  ProfileViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Ahmad Musallam on 06/03/2024.
//
import UIKit
import SnapKit

class ProfilePageViewController: UIViewController {
    
    
    // MARK: - Properties
    var balance: AmountChange?
    var token: String?
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: view.topAnchor, paddingTop: 88,
                                width: 120, height: 120)
        profileImageView.layer.cornerRadius = 120 / 2
        
       // view.addSubview(messageButton)
     //   messageButton.anchor(top: view.topAnchor, left: view.leftAnchor,
               //              paddingTop: 64, paddingLeft: 28, width: 24, height: 20)
        //
        //            view.addSubview(followButton)
        //            followButton.anchor(top: view.topAnchor, right: view.rightAnchor,
        //                                 paddingTop: 64, paddingRight: 32, width: 32, height: 32)
        
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
        
        view.addSubview(emailLabel)
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
        
        view.addSubview(balanceLabel)
        balanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        balanceLabel.anchor(top: emailLabel.bottomAnchor, paddingTop: 12)
        
        return view
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Coded")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
//
//    let messageButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(imageLiteralResourceName:"mail_message").withRenderingMode(.alwaysOriginal), for: .normal)
//        button.addTarget(ProfilePageViewController.self, action: #selector(handleMessageUser), for: .touchUpInside)
//        return button
//    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Nada"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Nada@gmail.com"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Balance: KWD"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    let myDepositButton = UIButton(type: .system)
    
    let myWithdrawButton = UIButton(type: .system)

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        autoLayout()
        myDepositButton.addTarget(self, action: #selector(depositTapped), for: .touchUpInside)
        myWithdrawButton.addTarget(self, action: #selector(withdrawTapped), for: .touchUpInside)

    }
    
    func setupUI(){
        view.addSubview(containerView)
        
        view.addSubview(myDepositButton)
        myDepositButton.setTitle("Deposit", for: .normal)
        view.addSubview(myWithdrawButton)
        myWithdrawButton.setTitle("Withdraw", for: .normal)
        
    }
    
    func autoLayout(){
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor,
                             right: view.rightAnchor, height: 350)
        myDepositButton.backgroundColor = .purple
        myDepositButton.setTitleColor(.white, for: .normal)
        myDepositButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        myDepositButton.layer.cornerRadius = 10
        myDepositButton.layer.borderWidth = 0.5
        myDepositButton.layer.borderColor = UIColor.black.cgColor
        
        myDepositButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
        
        myWithdrawButton.backgroundColor = .purple
        myWithdrawButton.setTitleColor(.white, for: .normal)
        myWithdrawButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        myWithdrawButton.layer.cornerRadius = 10
        myWithdrawButton.layer.borderWidth = 0.5
        myWithdrawButton.layer.borderColor = UIColor.black.cgColor
        
        myWithdrawButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(25)
            make.trailing.equalToSuperview().inset(50)
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Selectors
    
    @objc func handleMessageUser() {
        print("Message user here..")
    }
    

    
    @objc func depositTapped(){
         let depositVC = DepositViewController()
        depositVC.modalPresentationStyle = .popover
         self.present(depositVC, animated: true)
     }
    @objc func withdrawTapped(){
         let withdrawVC = WithdrawViewController()
        withdrawVC.modalPresentationStyle = .popover
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
