//
//  CommentSheetViewModel.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 11.07.2024.
//

import Foundation
import Combine
import UIKit

class CommentSheetViewModel {
    
    init(reviewRepository: ReviewRepository, userRepository: UserRepository) {
        self.reviewRepository = reviewRepository
        self.userRepository = userRepository
        userRepository.$avatar
            .sink { [weak self] avatar in
                self?.avatar = avatar
            }
            .store(in: &cancellables)
    }
    
    let reviewRepository: ReviewRepository
    let userRepository: UserRepository
    private var cancellables = Set<AnyCancellable>()
    
    lazy var review: String = reviewRepository.review.review {
        didSet {
            reviewRepository.review.review = review
        }
    }
    
    lazy var suggestion: String = reviewRepository.review.suggestion {
        didSet {
            reviewRepository.review.suggestion = suggestion
        }
    }
    
    @Published var avatar: UIImage?
    
    func userDidTapSubmitComment() {
        reviewRepository.submitComment()
    }
    
}
