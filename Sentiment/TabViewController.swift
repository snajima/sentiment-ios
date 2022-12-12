//
//  TabViewController.swift
//  Sentiment
//
//  Created by Shungo Najima on 11/30/22.
//

import UIKit

class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let tab1 = EntryViewController(date: Date())
        let tab1Item = UITabBarItem(title: "Today's Entry", image: UIImage(named: "diary"), selectedImage: UIImage(named: "diary"))
        tab1.tabBarItem = tab1Item
        
        let tab2 = CalendarViewController()
        let tab2Item = UITabBarItem(title: "Calendar", image: UIImage(named: "calendar"), selectedImage: UIImage(named: "calendar"))
        tab2.tabBarItem = tab2Item

        let tab3 = ProfileViewController()
        let tab3Item = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile"))
        tab3.tabBarItem = tab3Item
        
        self.setViewControllers([tab1, tab2, tab3], animated: true)
        self.tabBar.tintColor = UIColor.warmPink()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
