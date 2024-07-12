//
//  DIContainer.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 12.07.2024.
//

import Foundation
import Swinject

final class DIContainer {
    
    private static let container = Container()
    
    // MARK: -
    
    static func register<T>(
        name: String? = nil,
        factory: @escaping (Resolver) -> T
    ) {
        container.register(T.self, name: name, factory: factory)
    }
    
    static func  resolve<T>(_ serviceType: T.Type, name: String? = nil) -> T? {
        return container.resolve(serviceType, name: name)
    }
    
    // MARK: -
    static func registerDependencies() {
        
        container.register(NetworkManager.self) { r in
            return NetworkManager()
        }
        .inObjectScope(.container)
        
        container.register(ReviewRepository.self) { r in
            let networkManager = container.resolve(NetworkManager.self)!
            return ReviewRepository(networkManager: networkManager)
        }
        .inObjectScope(.container)
        
        container.register(UserRepository.self) { r in
            let networkManager = container.resolve(NetworkManager.self)!
            return UserRepository(networkManager: networkManager)
        }
        .inObjectScope(.container)

    }
    
    // MARK: -
    static func resolveNetworkManager() -> NetworkManager {
        return container.resolve(NetworkManager.self)!
    }
    
    static func resolveReviewRepository() -> ReviewRepository {
        return container.resolve(ReviewRepository.self)!
    }
    
    static func resolveUserRepository() -> UserRepository {
        return container.resolve(UserRepository.self)!
    }
    
}
