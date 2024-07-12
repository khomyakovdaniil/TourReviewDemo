//
//  UserRepository.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 12.07.2024.
//

import Foundation
import UIKit
import Combine

class UserRepository {
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        loadData()
    }
    
    let networkManager: NetworkManager
    
    @Published var avatar: UIImage?
    
    func loadData() {
        networkManager.loadAvatar { [weak self] avatar in
            self?.avatar = avatar
        }
    }
}
