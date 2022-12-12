//
//  EntryViewController.swift
//  Sentiment
//
//  Created by Shungo Najima on 12/3/22.
//

import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController {
    let dates = ["All Time", "1 Week", "1 Month", "3 Months", "6 Months", "1 Year", "3 Years"]
    var emotions: [(emotion: String, percentage: CGFloat)] = []
    var selectedDate: String = "All Time"
    var selectedRow = 0
    
    var backgroundView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width + 500, height: 500)
        view.layer.insertSublayer(CAGradientLayer.pinkCircularGradientLayer(in: view.frame, cornerRadius: UIScreen.main.bounds.width * 0.5 + 250), at: 0)
        
        return view
    }()
    
    var profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Sentiment Profile"
        label.textColor = .white
        label.font = UIFont(name: "Quicksand-SemiBold", size: 30)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var textBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.shadowColor = UIColor.systemGray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        return view
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        if let googleName = GIDSignIn.sharedInstance.currentUser?.profile?.givenName {
            label.text = "Hi, \(googleName)!"
        } else {
            label.text = "Hi!"
        }
        label.textColor = .gray
        label.font = UIFont(name: "Quicksand-SemiBold", size: 25)
        return label
    }()
    
    var rangeLabel: UILabel = {
        let label = UILabel()
        label.text = "Moods (All Time)"
        label.textColor = .gray
        label.font = UIFont(name: "Quicksand-SemiBold", size: 20)
        return label
    }()
    
    var datePickerButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(named: "options")?.withRenderingMode(.alwaysTemplate)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(presentPickerView), for: .touchUpInside)
        return button
    }()
    
    lazy var emotionTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        return tableView
    }()
    
    let userLogoutButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "logout")?.withRenderingMode(.alwaysTemplate)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor.offWhite()
        
        emotionTableView.dataSource = self
        emotionTableView.delegate = self
        emotionTableView.register(EmotionTableViewCell.self, forCellReuseIdentifier: "EmotionTableViewCell")
        loadDistributions(delta: DateComponents(year: -5))
        
        [backgroundView, profileLabel, userLogoutButton, textBoxView, nameLabel, rangeLabel, datePickerButton, emotionTableView].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -150),
            backgroundView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -0),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -250),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 250),
            
            userLogoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 27.5),
            userLogoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 52.5),
            userLogoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            userLogoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            profileLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            
            textBoxView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 20),
            textBoxView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            textBoxView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textBoxView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            nameLabel.topAnchor.constraint(equalTo: textBoxView.topAnchor, constant: 30),
            nameLabel.centerXAnchor.constraint(equalTo: textBoxView.centerXAnchor),
            
            rangeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            rangeLabel.leadingAnchor.constraint(equalTo: textBoxView.leadingAnchor, constant: 30),
            
            datePickerButton.trailingAnchor.constraint(equalTo: textBoxView.trailingAnchor, constant: -10),
            datePickerButton.centerYAnchor.constraint(equalTo: rangeLabel.centerYAnchor),
            datePickerButton.widthAnchor.constraint(equalToConstant: 30),
            datePickerButton.heightAnchor.constraint(equalToConstant: 30),
            
            emotionTableView.leadingAnchor.constraint(equalTo: textBoxView.leadingAnchor, constant: 30),
            emotionTableView.trailingAnchor.constraint(equalTo: textBoxView.trailingAnchor, constant: -30),
            emotionTableView.topAnchor.constraint(equalTo: rangeLabel.bottomAnchor, constant: 30),
            emotionTableView.bottomAnchor.constraint(equalTo: textBoxView.bottomAnchor, constant: -30),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func presentPickerView() {
        let vc = UIViewController()
        let pickerWidth = UIScreen.main.bounds.width - 10
        let pickerHeight = UIScreen.main.bounds.height / 2
        vc.preferredContentSize = CGSize(width: pickerWidth, height: pickerHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: pickerWidth, height: pickerHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select Time Frame", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = datePickerButton
        alert.popoverPresentationController?.sourceRect = datePickerButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            self.selectedDate = self.dates[self.selectedRow]
            self.rangeLabel.text = "Moods (\(self.selectedDate))"
            
            switch self.selectedDate {
            case "1 Week":
                self.loadDistributions(delta: DateComponents(day: -7))
            case "1 Month":
                self.loadDistributions(delta: DateComponents(month: -1))
            case "3 Months":
                self.loadDistributions(delta: DateComponents(month: -3))
            case "6 Months":
                self.loadDistributions(delta: DateComponents(month: -6))
            case "1 Year":
                self.loadDistributions(delta: DateComponents(year: -1))
            case "3 Years":
                self.loadDistributions(delta: DateComponents(year: -3))
            case "All Time":
                self.loadDistributions(delta: DateComponents(year: -5))
            default:    
                self.loadDistributions(delta: DateComponents(year: -5))
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func logout() {
        GIDSignIn.sharedInstance.signOut()
        self.navigationController?.pushViewController(GoogleAuthLoginVC(), animated: true)
    }
    
    func loadDistributions(delta: DateComponents) {
        let theCalendar     = Calendar.current
        let startDate        = theCalendar.date(byAdding: delta, to: Date())!
        var output: [String: CGFloat] = [:]

        NetworkManager.getEntryByUserIdAndDateRange(poster_id: 1, start_date: startDate, end_date: Date()) { result in
            switch result {
            case .success(let emotions):
                do {
                    try output = emotions.asFloatDictionary()
                } catch {
                    output["none"] = 1.0
                }
            case .failure(_):
                output["none"] = 1.0
            }
            
            self.emotions = output.map { (key, value) in
                return (key, value)
            }
            // sort self.emotions by 1st: second element in tuple (descending), 2nd: alphabetically by first element
            self.emotions.sort(by: { $0.1 > $1.1 || ($0.1 == $1.1 && $0.0 < $1.0) })
            self.emotionTableView.reloadData()
        }
    }
}

extension ProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmotionTableViewCell", for: indexPath) as! EmotionTableViewCell
        cell.configure(emotion: emotions[indexPath.row].0, percentage: emotions[indexPath.row].1)
        
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dates[row]
    }
}
