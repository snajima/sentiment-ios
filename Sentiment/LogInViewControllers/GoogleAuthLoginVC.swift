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
    var backgroundView: UIView = {
        let view = UIView()
        let width = UIScreen.main.bounds.width * 1.5
        let height = UIScreen.main.bounds.height
        view.frame = CGRect(x: -width / 2.0, y: -height / 2.0, width: width, height: height)
        view.layer.insertSublayer(CAGradientLayer.pinkCircularGradientLayer(in: view.frame, cornerRadius: 0), at: 0)
        
        return view
    }()
    
    var signInButton = GIDSignInButton()
    
    var introLabel: UILabel = {
        let intro = UILabel()
        intro.text = "First time with Sentiment?"
        intro.font = UIFont(name: "Quicksand-SemiBold", size: 30)
        intro.textColor = .white
        return intro
    }()
    
    var circle: UIView = {
        let view = UIView()
        let radius = 300
        view.frame = CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2)
        view.layer.insertSublayer(CAGradientLayer.radiallyCircleGradientLayer(in: view.frame, color: .warmPink()), at: 0)
        
        return view
    }()
    
    let logoImage = UIImageView()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        signInButton.style = .wide
        
        logoImage.image = UIImage(named: "logo")
        logoImage.contentMode = .scaleAspectFit
        
        [backgroundView, circle, logoImage, introLabel, signInButton].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            signInButton.centerXAnchor.constraint(equalTo: introLabel.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -200),
            logoImage.heightAnchor.constraint(equalToConstant: 150),
            
            introLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            introLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30),
        ])
    }
    
    @objc func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.navigationController?.pushViewController(TabViewController(), animated: true)
                if let userToken = user?.authentication.idToken {
                    NetworkManager.sendToken(token: userToken) { User in
                        print(User)
                    }
                }
            }
            // TODO: make POST request to backend
           //  user?.profile
            
        }

    }
    
}
