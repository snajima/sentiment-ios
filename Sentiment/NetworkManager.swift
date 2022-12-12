//
//  NetworkManager.swift
//  Sentiment
//
//  Created by Shungo Najima on 11/30/22.
//

import Foundation
import Alamofire

class NetworkManager {
    static let host: String = "http://localhost:8000"
    
    
    static func sendToken(token: String, completion: @escaping (User) -> Void) {
        let endpoint = "\(host)/login/"
        let params = [
            "token": token
        ]
        
        AF.request(endpoint, method: .post,parameters: params,encoding: JSONEncoding.default).validate().responseData { response in
            switch (response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let eventResponse = try? jsonDecoder.decode(User.self, from: data) {
                    completion(eventResponse)
                } else {
                    print("Failed to decode sendToken")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func getAllEntries(completion: @escaping (Entries) -> Void) {
        let endpoint = "\(host)/entries/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            debugPrint(response)
            switch (response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let entriesResponse = try? jsonDecoder.decode(Entries.self, from: data) {
                    completion(entriesResponse)
                } else {
                    // print the error
                    print("Failed to decode getAllEntries")
                    print(String(data: data, encoding: .utf8)!)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func postEntry(entry_description: String, poster_id: Int, date: Date, emotion: String?, completion: @escaping (Entry) -> Void) {
        let endpoint = "\(host)/entries/"
        
        let params: [String: Any] = [
            "entry_description": entry_description,
            "poster_id": poster_id,
            "date": convertDateToString(date: date),
            "emotion": emotion as Any,
        ]
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            debugPrint(response)
            switch (response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let entryResponse = try? jsonDecoder.decode(Entry.self, from: data) {
                    completion(entryResponse)
                } else {
                    print("Failed to decode postEntry")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getEntriesByUserId(poster_id: Int, completion: @escaping (Entries) -> Void) {
        let endpoint = "\(host)/entries/user/\(poster_id)/"
        
        AF.request(endpoint, method: .get).validate().responseData { response in
            debugPrint(response)
            switch (response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let entriesResponse = try? jsonDecoder.decode(Entries.self, from: data) {
                    completion(entriesResponse)
                } else {
                    print("Failed to decode sendToken")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getEntryByUserIdAndDate(poster_id: Int, date: Date, completion: @escaping (Result<Entry, Error>) -> Void) {
        let endpoint = "\(host)/entries/user/\(poster_id)/"
        
        let params: [String: Any] = [
            "date": convertDateToString(date: date),
        ]
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            debugPrint(response)
            switch (response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let entryResponse = try? jsonDecoder.decode(Entry.self, from: data) {
                    completion(.success(entryResponse))
                } else {
                    print("Failed to decode getEntryByUserIdAndDate")
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    static func getEntryByUserIdAndDateRange(poster_id: Int, start_date: Date, end_date: Date, completion: @escaping (Result<Emotions, Error>) -> Void) {
        let endpoint = "\(host)/entries/user/\(poster_id)/range/"
        
        let params: [String: Any] = [
            "start_date": convertDateToString(date: start_date),
            "end_date": convertDateToString(date: end_date),
        ]
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            debugPrint(response)
            switch (response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let entryResponse = try? jsonDecoder.decode(Emotions.self, from: data) {
                    completion(.success(entryResponse))
                } else {
                    print("Failed to decode getEntryByUserIdAndDate")
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
