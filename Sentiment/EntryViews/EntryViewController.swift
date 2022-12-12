//
//  EntryViewController.swift
//  Sentiment
//
//  Created by Shungo Najima on 12/1/22.
//

import UIKit

class EntryViewController: UIViewController {
    var date: Date?
    
    var backgroundView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width + 500, height: 500)
        view.layer.insertSublayer(CAGradientLayer.pinkCircularGradientLayer(in: view.frame, cornerRadius: UIScreen.main.bounds.width * 0.5 + 250), at: 0)
        
        return view
    }()
    
    var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = .white
        label.font = UIFont(name: "Quicksand-SemiBold", size: 30)
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
    
    var promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Your thoughts..."
        label.textColor = UIColor.gray
        label.font = UIFont(name: "Quicksand-SemiBold", size: 25)
        return label
    }()
    
    var diaryBoxInput: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Quicksand", size: 20)
        return textView
    }()
    
    var evaluatedMoodLabel: UILabel = {
        let label = UILabel()
        label.text = "Your evaluated mood:"
        label.textColor = UIColor.gray
        label.font = UIFont(name: "Quicksand-SemiBold", size: 25)
        return label
    }()
    
    var moodLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: "Quicksand", size: 20)
        return label
    }()
    
    var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand-SemiBold", size: 60)
        return label
    }()
    
    var buttonLabel: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.warmPink(), for: .normal)
        button.setTitleColor(UIColor.warmPink(alpha: 0.5), for: .highlighted)
        button.layer.cornerRadius = 10
        button.titleLabel?.font =  UIFont(name: "Quicksand-SemiBold", size: 25)
        button.addTarget(self, action: #selector(submitEntryPressed), for: .touchUpInside)
        return button
    }()
    
    init(date: Date) {
        super.init(nibName: nil, bundle: nil)
        self.date = date
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor.offWhite()
        
        let today = Date()
        let c = Calendar.current
        let d = self.date!
        if c.component(.day, from: d) != c.component(.day, from: today) ||
            c.component(.month, from: d) != c.component(.month, from: today) ||
            c.component(.year, from: d) != c.component(.year, from: today) {
            let year = c.component(.year, from: self.date!)
            let month = c.component(.month, from: self.date!)
            let day = c.component(.day, from: self.date!)
            todayLabel.text = "\(month)/\(day), \(year)"
        }
        
        [backgroundView, todayLabel, textBoxView, promptLabel, diaryBoxInput, emojiLabel, moodLabel, evaluatedMoodLabel, buttonLabel].forEach { subView in
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
            
            emojiLabel.bottomAnchor.constraint(equalTo: buttonLabel.topAnchor, constant: -10),
            emojiLabel.centerXAnchor.constraint(equalTo: textBoxView.centerXAnchor),
            
            moodLabel.bottomAnchor.constraint(equalTo: emojiLabel.topAnchor, constant: -10),
            moodLabel.centerXAnchor.constraint(equalTo: textBoxView.centerXAnchor),
            
            evaluatedMoodLabel.bottomAnchor.constraint(equalTo: moodLabel.topAnchor, constant: -15),
            evaluatedMoodLabel.centerXAnchor.constraint(equalTo: textBoxView.centerXAnchor),
        
            diaryBoxInput.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 20),
            diaryBoxInput.bottomAnchor.constraint(equalTo: evaluatedMoodLabel.topAnchor, constant: -20),
            diaryBoxInput.leadingAnchor.constraint(equalTo: textBoxView.leadingAnchor, constant: 30),
            diaryBoxInput.trailingAnchor.constraint(equalTo: textBoxView.trailingAnchor, constant: -30),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadEntry()
    }
    
    func loadEntry() {
        NetworkManager.getEntryByUserIdAndDate(poster_id: 1, date: self.date!) { result in
            switch result {
            case .success(let entry):
                if (entry.entry_description != "") {
                    self.diaryBoxInput.text = entry.entry_description
                    self.diaryBoxInput.textColor = UIColor.black
                    
                    self.moodLabel.text = entry.emotion
                    
                    if (emotionToEmoji.keys.contains(entry.emotion.lowercased())) {
                        self.emojiLabel.text = emotionToEmoji[entry.emotion.lowercased()]
                    } else {
                        self.emojiLabel.text = "❓"
                    }
                } else {
                    self.diaryBoxInput.text = "..."
                    self.diaryBoxInput.textColor = UIColor.lightGray
                    
                    self.moodLabel.text = "None"
                    self.emojiLabel.text = "🫥"
                }
            case .failure(let _):
                self.diaryBoxInput.text = "..."
                self.diaryBoxInput.textColor = UIColor.lightGray
                
                self.moodLabel.text = "None"
                self.emojiLabel.text = "🫥"
            }
        }
    }
    
    @objc func submitEntryPressed() {
        var entryString = ""
        if (self.diaryBoxInput.textColor == UIColor.black) {
            entryString = self.diaryBoxInput.text
        }
        
        NetworkManager.postEntry(entry_description: entryString, poster_id: 1, date: self.date!, emotion: nil, completion: { entry in
            self.moodLabel.text = entry.emotion
            
            if (emotionToEmoji.keys.contains(entry.emotion.lowercased())) {
                self.emojiLabel.text = emotionToEmoji[entry.emotion.lowercased()]
            } else {
                self.emojiLabel.text = "❓"
            }
        })
    }
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
