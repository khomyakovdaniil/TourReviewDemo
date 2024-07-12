//
//  NetworkManager.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 11.07.2024.
//

import Foundation
import Moya

class NetworkManager {
    
    let provider = MoyaProvider<Api>()
    
    func loadAvatar(completion: @escaping (UIImage?) -> Void) {
        provider.request(.getAvatar) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    guard let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any],
                          let data = json.first?.value as? [String: Any],
                          let user = data["author"] as? [String : Any],
                          let urlString = user["avatar"] as? String,
                          let url = URL(string: urlString) else {
                        return
                    }
                    self?.getData(from: url) { data, response, error in
                        guard let data = data, 
                                error == nil,
                              let image = UIImage(data: data) else {
                            return
                        }
                        completion(image)
                    }
                } catch {
                    print(error)
                }
            case .failure(let error):
                completion(nil) // No error handling since the server doesn't work
            }
        }
    }
    
    func submit(rating: TourReview, completion: @escaping () -> Void) {
        provider.request(.uploadRating(rating)) { result in
            switch result {
            case .success(let response):
                completion()
            case .failure(let error):
                completion() // No error handling since the server doesn't work
            }
        }
    }
    
    func submit(comments: TourReview, completion:  @escaping () -> Void) {
        provider.request(.uploadComment(comments)) { result in
            switch result {
            case .success(let response):
                completion()
            case .failure(let error):
                completion() // No error handling since the server doesn't work
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
