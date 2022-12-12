//
//  BookmarksViewController.swift
//  Sentiment
//
//  Created by Shungo Najima on 11/30/22.
//

import UIKit

typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

class CalendarViewController: UIViewController {
    var calendarView: UICalendarView = {
        let calendarView = UICalendarView()
        calendarView.locale = .current
        calendarView.calendar = .current
        calendarView.fontDesign = .rounded
        calendarView.tintColor = UIColor.warmPink()
        return calendarView
    }()
    
    var contrastView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        return view
    }()
    
    var calendarLabel: UILabel = {
        let label = UILabel()
        label.text = "Calendar"
        label.textColor = .white
        label.font = UIFont(name: "Quicksand-SemiBold", size: 30)
        return label
    }()
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.layer.addSublayer(CAGradientLayer.pinkGradientLayer(in: view.frame))
        
        calendarView.delegate = self
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        
        [contrastView, calendarLabel, calendarView].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            calendarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            calendarLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            calendarLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            contrastView.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: 25),
            contrastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100),
            contrastView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contrastView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            calendarView.topAnchor.constraint(equalTo: contrastView.topAnchor, constant: 16),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        let viewer = EntryViewController(date: NSCalendar.current.date(from: dateComponents!)!)
        navigationController?.present(viewer, animated: true)
    }
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return .customView {
            let emoji = UILabel()
            emoji.text = ""
            return emoji
        }
    }
}
