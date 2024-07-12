//
//  Router.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 11.07.2024.
//

import Foundation
import UIKit

class Router {
    
    static var window: UIWindow?
    
    static func openStartVC() {
        let startViewController = StartViewController()
        let navController = UINavigationController(rootViewController: startViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    static func openRatingSheet() {
        if let topController = window?.rootViewController {
            let reviewRepository = DIContainer.resolveReviewRepository()
            let userRepository = DIContainer.resolveUserRepository()
            let ratingSheetVM = RatingSheetViewModel(reviewRepository: reviewRepository,
                                                     userRepository: userRepository)
            let ratingSheetVC = RatingSheetView(viewModel: ratingSheetVM)
            ratingSheetVC.modalPresentationStyle = .pageSheet
            topController.present(ratingSheetVC, animated: true, completion: nil)
        }
    }
    
    
    static func openCommentSheet() {
        if let topController = window?.rootViewController {
            let reviewRepository = DIContainer.resolveReviewRepository()
            let userRepository = DIContainer.resolveUserRepository()
            let commentSheetVM = CommentSheetViewModel(reviewRepository: reviewRepository,
                                                       userRepository: userRepository)
            let commentSheetVC = CommentSheetView(viewModel: commentSheetVM)
            commentSheetVC.modalPresentationStyle = .pageSheet
            topController.present(commentSheetVC, animated: true, completion: nil)
        }
    }
    
}
