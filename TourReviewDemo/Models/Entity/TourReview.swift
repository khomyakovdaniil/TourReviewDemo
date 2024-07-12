//
//  TourReview.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 11.07.2024.
//

import Foundation

struct TourReview: Codable {
    var id: Int
    var general: Int = 2
    var guide: Int = 2
    var info: Int = 2
    var navigation: Int = 2
    var review: String = ""
    var suggestion: String = ""
}
