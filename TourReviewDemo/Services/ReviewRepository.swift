//
//  ReviewRepository.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 11.07.2024.
//

import Foundation

class ReviewRepository {
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    let networkManager: NetworkManager
    
    var review = TourReview(id: Int.random(in: 0...999))
    
    func submitRating() {
        networkManager.submit(rating: review) {
            
        }
    }
    
    func submitComment() {
        networkManager.submit(comments: review) {
            
        }
    }
    
}
