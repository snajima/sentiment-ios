//
//  EmotionCollectionViewCell.swift
//  Sentiment
//
//  Created by Shungo Najima on 12/12/22.
//

import UIKit

class EmotionTableViewCell: UITableViewCell {
    let padding: CGFloat = 10
    
    let emotionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Quicksand", size: 20)
        return label
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Quicksand", size: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.addSubview(emotionLabel)
        contentView.addSubview(percentageLabel)
        contentView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            // add constraints such that emotionLabel appears on the left side of the cell
            // and percentageLabel appears on the right side of the cell
            // and both labels are vertically centered in the cell
            emotionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            emotionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            emotionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            emotionLabel.heightAnchor.constraint(equalToConstant: 50),

            percentageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            percentageLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            percentageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            percentageLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(emotion: String, percentage: CGFloat) {
        emotionLabel.text = "\(emotionToEmoji[emotion] ?? "🫥") \(emotion)"
        percentageLabel.text = "\(round(percentage * 1000) / 10.0)%"
    }
}

