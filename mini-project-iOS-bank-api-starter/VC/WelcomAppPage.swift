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
    let signInButton = UIButton(type: .system)
    let signUpButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyGradientBackground()
    }

    private func setupUI() {
        view.backgroundColor = .white

        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit

        appNameLabel.textAlignment = .center
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 24)

        styleButton(signInButton, title: "Sign In")
        styleButton(signUpButton, title: "Sign Up", backgroundColor: UIColor.lightGray)

        view.addSubview(logoImageView)
        view.addSubview(appNameLabel)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)

        setupLayout()
    }

    private func styleButton(_ button: UIButton, title: String, backgroundColor: UIColor = UIColor.lightGray, textColor: UIColor = .black) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(textColor, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        button.addTarget(self, action: title == "Sign In" ? #selector(navigateToSignIn) : #selector(navigateToSignUp), for: .touchUpInside)
    }


    private func setupLayout() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            
            make.centerX.equalToSuperview().offset(-13)
            make.height.equalTo(290)
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

    private func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()

        // Create the custom color with RGB values (255, 252, 240)
        let customColor = UIColor(red: 255/255, green: 252/255, blue: 240/255, alpha: 1.0)

        // Use the custom color and systemPurple in the gradient
        gradientLayer.colors = [customColor.cgColor, UIColor.systemMint.cgColor]

        // Define the locations for the gradient stops
        gradientLayer.locations = [0.0, 3.0]

        // Set the frame of the gradient layer to match the bounds of the view
        gradientLayer.frame = view.bounds

        // Insert the gradient layer at the bottom of the view's layer stack
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    @objc private func navigateToSignIn() {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }

    @objc private func navigateToSignUp() {
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
}
