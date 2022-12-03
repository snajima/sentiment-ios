//
//  EntryViewController.swift
//  Sentiment
//
//  Created by Shungo Najima on 12/1/22.
//

import UIKit

class EntryViewController: UIViewController {
    var date: Date?
    var calendar: Calendar?
    
    var backgroundView: UIView = {
        let background = UIView()
        background.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width + 500, height: 500)
        background.layer.insertSublayer(CAGradientLayer.pinkCircularGradientLayer(in: background.frame, cornerRadius: UIScreen.main.bounds.width * 0.5 + 250), at: 0)
        
        return background
    }()
    
    var todayLabel: UILabel = {
        let today = UILabel()
        today.text = "Today"
        today.textColor = .white
        today.font = UIFont(name: "Quicksand-SemiBold", size: 30)
        return today
    }()
    
    var textBoxView: UIView = {
        let textBox = UIView()
        textBox.backgroundColor = .white
        textBox.layer.cornerRadius = 30
        textBox.layer.shadowColor = UIColor.systemGray.cgColor
        textBox.layer.shadowOpacity = 0.3
        textBox.layer.shadowOffset = CGSize(width: 0, height: 10)
        return textBox
    }()
    
    var promptLabel: UILabel = {
        let prompt = UILabel()
        prompt.text = "Your thoughts..."
        prompt.textColor = UIColor.gray
        prompt.font = UIFont(name: "Quicksand-SemiBold", size: 25)
        return prompt
    }()
    
    var diaryBoxInput: UITextView = {
        let input = UITextView()
        input.text = "..."
        input.textColor = UIColor.lightGray
        input.font = UIFont(name: "Quicksand", size: 20)
        return input
    }()
    
    var buttonLabel: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.warmPink(), for: .normal)
        button.setTitleColor(UIColor.warmPink(alpha: 0.5), for: .highlighted)
        button.layer.cornerRadius = 10
        button.titleLabel?.font =  UIFont(name: "Quicksand-SemiBold", size: 25)
        return button
    }()
    
    init(date: Date) {
        super.init(nibName: nil, bundle: nil)
        self.date = date
        self.calendar = Calendar.current

//        dateName.text = "🗓 " + convertUnixToString(date: event.date)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor.offWhite()
        
        let today = Date()
        let c = self.calendar!
        let d = self.date!
        if c.component(.day, from: d) != c.component(.day, from: today) ||
            c.component(.month, from: d) != c.component(.month, from: today) ||
            c.component(.year, from: d) != c.component(.year, from: today) {
            let year = c.component(.year, from: self.date!)
            let month = c.component(.month, from: self.date!)
            let day = c.component(.day, from: self.date!)
            todayLabel.text = "\(month)/\(day), \(year)"
        }
        
        [backgroundView, todayLabel, textBoxView, promptLabel, diaryBoxInput, buttonLabel].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        diaryBoxInput.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -100),
            backgroundView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -0),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -250),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 250),
            
            todayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            todayLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            todayLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            textBoxView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 25),
            textBoxView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            textBoxView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textBoxView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            promptLabel.topAnchor.constraint(equalTo: textBoxView.topAnchor, constant: 30),
            promptLabel.leadingAnchor.constraint(equalTo: textBoxView.leadingAnchor, constant: 30),
            promptLabel.trailingAnchor.constraint(equalTo: textBoxView.trailingAnchor, constant: -30),
            
            buttonLabel.bottomAnchor.constraint(equalTo: textBoxView.bottomAnchor, constant: -15),
            buttonLabel.centerXAnchor.constraint(equalTo: textBoxView.centerXAnchor),
            buttonLabel.widthAnchor.constraint(equalToConstant: 100),
            buttonLabel.heightAnchor.constraint(equalToConstant: 60),
        
            diaryBoxInput.topAnchor.constraint(equalTo: promptLabel.topAnchor, constant: 40),
            diaryBoxInput.bottomAnchor.constraint(equalTo: buttonLabel.topAnchor, constant: -10),
            diaryBoxInput.leadingAnchor.constraint(equalTo: textBoxView.leadingAnchor, constant: 30),
            diaryBoxInput.trailingAnchor.constraint(equalTo: textBoxView.trailingAnchor, constant: -30),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        loadBookmarkedEvents()
    }
    
    //    func loadBookmarkedEvents() {
    //        NetworkManager.getBookmarkedEvents() { events in
    //            self.bookmarkedEvents = events.savedEvents
    //            self.bookmarkedEventsTableView.reloadData()
    //            }
    //        }
    //    }
}

extension EntryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "..."
            textView.textColor = UIColor.lightGray
        }
    }
}
