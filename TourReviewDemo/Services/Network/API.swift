//
//  API.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 12.07.2024.
//

import Foundation
import Moya

enum Api: TargetType {
    
    case getAvatar
    case uploadRating(_ review: TourReview)
    case uploadComment(_ review: TourReview)
    
    public var baseURL: URL {
        switch self {
        case .getAvatar:
            return URL(string: "https://app.wegotrip.com")!
        default:
            return URL(string: "https://webhook.site")!
        }
    }

    public var path: String {
        switch self {
        case .getAvatar:
            "/api/v2/products/3728/"
        case .uploadRating:
            "/c8f2041c-c57e-433f-853f-1ef739702903"
        case .uploadComment:
            "/8b48049e-6f7a-4d17-b16b-4721ded8a046"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getAvatar:
            return .get
        case .uploadRating:
            return .post
        case .uploadComment:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .getAvatar:
            return .requestPlain
        case .uploadRating(review: let review):
            return .requestParameters(parameters: [
                "id": review.id,
                "general": review.general,
                "guide": review.guide,
                "info": review.info,
                "navigation": review.navigation
            ],
                                      encoding: JSONEncoding.default)
        case .uploadComment(review: let review):
            return .requestParameters(parameters: [
                "id": review.id,
                "review": review.review,
                "suggestion": review.suggestion
            ],
                                      encoding: JSONEncoding.default)
        }
        
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json; charset=UTF-8"]
    }

    public var validationType: ValidationType {
        return .successCodes
    }
}
