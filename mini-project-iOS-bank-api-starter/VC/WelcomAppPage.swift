//
//  WelcomAppPage.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Ahmad Musallam on 06/03/2024.
//
import SnapKit
import UIKit

class WelcomeAppPageViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let appNameLabel = UILabel()
    let signInButton = UIButton()
    let signUpButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        
        logoImageView.image = UIImage(named: "logoApp")
        logoImageView.contentMode = .scaleAspectFit
        
     
        appNameLabel.text = " App Bank"
        appNameLabel.textAlignment = .center
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.backgroundColor = UIColor.systemBlue
        signInButton.layer.cornerRadius = 5
        signInButton.addTarget(self, action: #selector(navigateToSignIn), for: .touchUpInside)
        
       
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor.systemBlue
        signUpButton.layer.cornerRadius = 5
        signUpButton.addTarget(self, action: #selector(navigateToSignUp), for: .touchUpInside)
        
      
        view.addSubview(logoImageView)
        view.addSubview(appNameLabel)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        setupLayout()
    }

    private func setupLayout() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            make.centerX.equalTo(view)
            make.height.equalTo(100)
            make.width.equalTo(logoImageView.snp.height).multipliedBy(1.0)
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
            make.left.right.equalTo(view).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(30)
            make.left.right.equalTo(view).inset(50)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(50)
            make.height.equalTo(50)
        }
    }

    @objc private func navigateToSignIn() {
      
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }

    @objc private func navigateToSignUp() {
        
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
}

