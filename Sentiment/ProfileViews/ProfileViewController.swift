//
//  EntryViewController.swift
//  Sentiment
//
//  Created by Shungo Najima on 12/3/22.
//

import UIKit

class ProfileViewController: UIViewController {
    var backgroundView: UIView = {
        let background = UIView()
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width + 500, height: 500)
        background.layer.insertSublayer(CAGradientLayer.pinkCircularGradientLayer(in: background.frame, cornerRadius: UIScreen.main.bounds.width * 0.5 + 250), at: 0)
        
        return background
    }()
    
    var profileLabel: UILabel = {
        let profile = UILabel()
        profile.text = "Your Profile"
        profile.textColor = .white
        profile.font = UIFont(name: "Quicksand-SemiBold", size: 30)
        return profile
    }()
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor.offWhite()
        
        [backgroundView, profileLabel].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -100),
            backgroundView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -0),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -250),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 250),
            
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            profileLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
