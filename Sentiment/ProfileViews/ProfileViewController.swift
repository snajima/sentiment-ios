//
//  EntryViewController.swift
//  Sentiment
//
//  Created by Shungo Najima on 12/3/22.
//

import UIKit

class ProfileViewController: UIViewController {
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
        label.text = "Hi, Stephen!"
        label.textColor = .gray
        label.font = UIFont(name: "Quicksand-SemiBold", size: 25)
        return label
    }()
    
    var lastWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "In the Last Week"
        label.textColor = .gray
        label.font = UIFont(name: "Quicksand-SemiBold", size: 20)
        return label
    }()

//    var barChartViewLastWeek: BarChartView
    
    var barChartViewLastWeek: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.offWhite().cgColor
        return view
    }()
    
    var lastMonthLabel: UILabel = {
        let label = UILabel()
        label.text = "In the Last Month"
        label.textColor = .gray
        label.font = UIFont(name: "Quicksand-SemiBold", size: 20)
        return label
    }()
    
    var barChartViewLastMonth: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.offWhite().cgColor
        return view
    }()
    
    var lastThreeMonthsLabel: UILabel = {
        let label = UILabel()
        label.text = "In the Last 3 Months"
        label.textColor = .gray
        label.font = UIFont(name: "Quicksand-SemiBold", size: 20)
        return label
    }()
    
    var barChartViewLastThreeMonths: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.offWhite().cgColor
        return view
    }()
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor.offWhite()
        
        barChartViewLastWeek = BarChartView(in: self.view.bounds, emotions: loadDistributions(days: 7))
        barChartViewLastWeek.layer.cornerRadius = 20
        barChartViewLastWeek.layer.borderWidth = 5
        barChartViewLastWeek.layer.borderColor = UIColor.offWhite().cgColor
        
        [backgroundView, profileLabel, textBoxView, nameLabel, lastWeekLabel, barChartViewLastWeek, lastMonthLabel, barChartViewLastMonth, lastThreeMonthsLabel, barChartViewLastThreeMonths].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -150),
            backgroundView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -0),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -250),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 250),
            
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            profileLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            textBoxView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 25),
            textBoxView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            textBoxView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textBoxView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            nameLabel.topAnchor.constraint(equalTo: textBoxView.topAnchor, constant: 30),
            nameLabel.centerXAnchor.constraint(equalTo: textBoxView.centerXAnchor),
            
            lastWeekLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            lastWeekLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            
            barChartViewLastWeek.topAnchor.constraint(equalTo: lastWeekLabel.bottomAnchor, constant: 15),
            barChartViewLastWeek.heightAnchor.constraint(equalToConstant: 40),
            barChartViewLastWeek.leadingAnchor.constraint(equalTo: textBoxView.leadingAnchor, constant: 30),
            barChartViewLastWeek.trailingAnchor.constraint(equalTo: textBoxView.trailingAnchor, constant: -30),
            
            lastMonthLabel.topAnchor.constraint(equalTo: barChartViewLastWeek.bottomAnchor, constant: 30),
            lastMonthLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            
            barChartViewLastMonth.topAnchor.constraint(equalTo: lastMonthLabel.bottomAnchor, constant: 15),
            barChartViewLastMonth.heightAnchor.constraint(equalToConstant: 40),
            barChartViewLastMonth.leadingAnchor.constraint(equalTo: textBoxView.leadingAnchor, constant: 30),
            barChartViewLastMonth.trailingAnchor.constraint(equalTo: textBoxView.trailingAnchor, constant: -30),
            
            lastThreeMonthsLabel.topAnchor.constraint(equalTo: barChartViewLastMonth.bottomAnchor, constant: 30),
            lastThreeMonthsLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor),
            
            barChartViewLastThreeMonths.topAnchor.constraint(equalTo: lastThreeMonthsLabel.bottomAnchor, constant: 15),
            barChartViewLastThreeMonths.heightAnchor.constraint(equalToConstant: 40),
            barChartViewLastThreeMonths.leadingAnchor.constraint(equalTo: textBoxView.leadingAnchor, constant: 30),
            barChartViewLastThreeMonths.trailingAnchor.constraint(equalTo: textBoxView.trailingAnchor, constant: -30),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadDistributions(days: Int) -> [String : CGFloat] {
        var dayComponent    = DateComponents()
        dayComponent.day    = -days
        let theCalendar     = Calendar.current
        let startDate        = theCalendar.date(byAdding: dayComponent, to: Date())!
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
        }
        return output
    }
}

class BarChartView: UIView {
    var emotions: [String: CGFloat]
    
    init(in frame: CGRect, emotions: [String : CGFloat]) {
        print("DEBUGING")
        print(emotions)
        self.emotions = emotions
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        var widthSoFar = 0.0
        for (emotion, percentage) in emotions {
            let emotionRect = CGRect(x: widthSoFar, y: 0, width: rect.size.width * percentage, height: rect.size.height)
            emotionToColor[emotion]!.set()
            guard let emotionContext = UIGraphicsGetCurrentContext() else { return }
            emotionContext.fill(emotionRect)
            widthSoFar += rect.size.width * percentage
        }
    }
}
