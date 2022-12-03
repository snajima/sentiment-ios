//
//  GoogleAuthLoginVC.swift
//  Sentiment
//
//  Created by Shungo Najima on 11/30/22.
//

import UIKit
import GoogleSignIn
import Firebase

class GoogleAuthLoginVC: ViewController {
    var signInButton = GIDSignInButton()
    var signInButtonView: UIView = {
        let view = UIView()
        let button = GIDSignInButton()
        view.addSubview(button)
        return view
    }()
    
    var introLabel: UILabel = {
        let intro = UILabel()
        intro.text = "First time with Sentiment?"
        intro.font = UIFont(name: "Montserrat-Medium", size: 16)
        return intro
    }()
    
    let logoImage = UIImageView()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        signInButton.style = .wide
        
        logoImage.image = UIImage(named: "logo")
        logoImage.contentMode = .scaleAspectFit
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        [logoImage, introLabel, signInButton].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            introLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            introLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            signInButton.centerXAnchor.constraint(equalTo: introLabel.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 30),
            
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            logoImage.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            logoImage.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            if let error = error {
                print(error.localizedDescription)
            }
            // TODO: make POST request to backend
           //  user?.profile.
            self.navigationController?.pushViewController(TabViewController(), animated: true)
            if let userToken = user?.authentication.idToken {
                NetworkManager.sendToken(token: userToken) { User in
                    print(User)
                }
            }
            
        }

    }
    
}
