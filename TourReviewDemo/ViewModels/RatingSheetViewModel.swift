//
//  RatingSheetViewModel.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 11.07.2024.
//

import Foundation
import UIKit
import Combine

class RatingSheetViewModel {
    
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
    
    lazy var general: Int = reviewRepository.review.general {
        didSet {
            reviewRepository.review.general = general
        }
    }
    
    lazy var guide: Int = reviewRepository.review.guide {
        didSet {
            reviewRepository.review.guide = guide
        }
    }
    
    lazy var info: Int = reviewRepository.review.info {
        didSet {
            reviewRepository.review.info = info
        }
    }
    
    lazy var navigation: Int = reviewRepository.review.navigation {
        didSet {
            reviewRepository.review.navigation = navigation
        }
    }
    
    @Published var avatar: UIImage?
    
    func userDidTapSubmitRating() {
        reviewRepository.submitRating()
        Router.openCommentSheet()
    }
    
    func userDidTapSkipAnswer() {
        Router.openCommentSheet()
    }
    
}
