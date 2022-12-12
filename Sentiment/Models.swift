//
//  Models.swift
//  Sentiment
//
//  Created by Shungo Najima on 11/30/22.
//

import UIKit

struct User: Codable {
    let id: Int
    let netid: String
    let first_name: String
    let last_name: String
    let phone_number: String
    let grade: String
    let profile_pic_url: String
    let pronouns: String
}

struct SimpleUser: Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let profile_pic_url: String?
    let grade: String?
    let pronouns: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case profile_pic_url
        case grade
        case pronouns
    }
}

struct Entry: Codable {
    let id: Int
    let poster: SimpleUser
    let entry_description: String
    let emotion: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case poster
        case entry_description
        case emotion
        case date
    }
}

struct Emotions: Codable {
    let joy: CGFloat?
    let anger: CGFloat?
    let disapproval: CGFloat?
    let disappointment: CGFloat?
    let neutral: CGFloat?
    let approval: CGFloat?
    let realization: CGFloat?
    let sadness: CGFloat?
    let annoyance: CGFloat?
    let disgust: CGFloat?
    let embarrassment: CGFloat?
    let surprise: CGFloat?
    let fear: CGFloat?
    let confusion: CGFloat?
    let optimism: CGFloat?
    let remorse: CGFloat?
    let love: CGFloat?
    let nervousness: CGFloat?
    let admiration: CGFloat?
    let excitement: CGFloat?
    let amusement: CGFloat?
    let grief: CGFloat?
    let curiosity: CGFloat?
    let desire: CGFloat?
    let gratitute: CGFloat?
    let caring: CGFloat?
    let relief: CGFloat?
    let pride: CGFloat?
}

struct Entries: Codable {
    let entries: [Entry]
}

func convertDateToString(date: Date) -> String {
    let c = Calendar.current
    let year = c.component(.year, from: date)
    let month = c.component(.month, from: date)
    let day = c.component(.day, from: date)
    return "\(month)-\(day)-\(year)"
}

var emotionToEmoji: [String: String] = ["joy": "😊",
                                        "anger": "😡",
                                        "disapproval": "👎",
                                        "disappointment": "😔",
                                        "neutral": "😐",
                                        "approval": "👍",
                                        "realization": "🫢",
                                        "sadness": "😞",
                                        "annoyance": "😒",
                                        "disgust": "🤮",
                                        "embarrassment": "😖",
                                        "surprise": "😲",
                                        "fear": "😱",
                                        "confusion": "🤔",
                                        "optimism": "😁",
                                        "remorse": "😣",
                                        "love": "🥰",
                                        "nervousness": "😰",
                                        "admiration": "😁",
                                        "excitement": "🤩",
                                        "amusement": "😂",
                                        "grief": "😟",
                                        "curiosity": "🧐",
                                        "desire": "😗",
                                        "gratitude": "☺️",
                                        "caring": "😇",
                                        "relief": "😮‍💨",
                                        "pride": "🥳"]

var emotionToColor: [String: UIColor] = ["joy": UIColor(red: 187/255, green: 226/255, blue: 158/255, alpha: 1), // green
                                         "anger": UIColor(red: 222/255, green: 85/255, blue: 71/255, alpha: 1), // red
                                         "disapproval": UIColor(red: 184/255, green: 169/255, blue: 216/255, alpha: 1), // purple
                                         "disappointment": UIColor(red: 222/255, green: 185/255, blue: 206/255, alpha: 1), // light purple
                                         "neutral": UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1), // off white
                                         "approval": UIColor(red: 208/255, green: 240/255, blue: 191/255, alpha: 1), // lighter green
                                         "realization": UIColor(red: 255/255, green: 250/255, blue: 215/255, alpha: 1), // yellow
                                         "sadness": UIColor(red: 204/255, green: 252/255, blue: 246/255, alpha: 1), // light blue
                                         "annoyance": UIColor(red: 232/255, green: 120/255, blue: 120/255, alpha: 1), // light red
                                         "disgust": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "embarrassment": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "surprise": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "fear": UIColor(red: 187/255, green: 205/255, blue: 247/255, alpha: 1), // blue
                                         "confusion": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "optimism": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "remorse": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "love": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "nervousness": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "admiration": UIColor(red: 254/255, green: 148/255, blue: 148/255, alpha: 1), // warm pink
                                         "excitement": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "amusement": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "grief": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "curiosity": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "desire": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "gratitude": UIColor(red: 239/255, green: 195/255, blue: 160/255, alpha: 1),
                                         "caring": UIColor(red: 252/255, green: 221/255, blue: 175/255, alpha: 1), // light orange
                                         "relief": UIColor(red: 253/255, green: 190/255, blue: 139/255, alpha: 1), // orange
                                         "pride": UIColor(red: 255/255, green: 209/255, blue: 209/255, alpha: 1), // light pink
                                         "none": UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1), // off white
                                        ]


extension Encodable {
  func asFloatDictionary() throws -> [String: CGFloat] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: CGFloat] else {
      throw NSError()
    }
    return dictionary
  }
}
