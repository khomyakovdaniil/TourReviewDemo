//
//  StartViewController.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 11.07.2024.
//

import UIKit
import TinyConstraints

class StartViewController: UIViewController {
    
    let rateButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.StartViewControllerStrings.button, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(rateTour), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(rateButton)
        rateButton.center(in: view)
    }
    

    @objc func rateTour() {
        Router.openRatingSheet()
    }

}
