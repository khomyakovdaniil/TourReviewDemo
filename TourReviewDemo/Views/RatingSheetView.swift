//
//  RatingSheetView.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 11.07.2024.
//

import UIKit
import Combine

class RatingSheetView: UIViewController {
    
    init(viewModel: RatingSheetViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewModel: RatingSheetViewModel
    private var cancellables = Set<AnyCancellable>()
    
    let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image =  UIImage(systemName: "person.crop.circle")!
        return view
    }()
    
    let congratsLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.text = Constants.RatingSheetViewStrings.congratsLabel
        view.font = .systemFont(ofSize: 18, weight: .bold)
        return view
    }()
    
    let generalRateView: RateView = {
        let view = RateView(text: Constants.RatingSheetViewStrings.generalRate)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let guideRateView: RateView = {
        let view = RateView(text: Constants.RatingSheetViewStrings.guideRate)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let infoRateView: RateView = {
        let view = RateView(text: Constants.RatingSheetViewStrings.infoRate)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let navigationRateView: RateView = {
        let view = RateView(text: Constants.RatingSheetViewStrings.navigationRate)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.RatingSheetViewStrings.continueButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(proceed), for: .touchUpInside)
        return button
    }()
    
    let skipAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.RatingSheetViewStrings.skipAnswerButton, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(skipAnswer), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        generalRateView.delegate = self
        guideRateView.delegate = self
        infoRateView.delegate = self
        navigationRateView.delegate = self
        binding()
        setupConstraints()
    }
    
    private func binding() {
        viewModel.$avatar
            .sink { [weak self] avatar in
                DispatchQueue.main.async {
                    self?.avatarImageView.image = avatar
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupConstraints() {
        view.addSubview(avatarImageView)
        view.addSubview(congratsLabel)
        view.addSubview(generalRateView)
        view.addSubview(guideRateView)
        view.addSubview(infoRateView)
        view.addSubview(navigationRateView)
        view.addSubview(continueButton)
        view.addSubview(skipAnswerButton)
        
        avatarImageView.height(80)
        avatarImageView.width(80)
        avatarImageView.top(to: view, offset: 16)
        avatarImageView.leading(to: view, offset: 12)
        
        congratsLabel.leading(to: view, offset: 12)
        congratsLabel.trailing(to: view, offset: -12)
        congratsLabel.topToBottom(of: avatarImageView, offset: 16)
        
        generalRateView.topToBottom(of: congratsLabel, offset: 16)
        generalRateView.leading(to: view, offset: 12)
        generalRateView.trailing(to: view, offset: -12)
        
        guideRateView.topToBottom(of: generalRateView, offset: 8)
        guideRateView.leading(to: view, offset: 12)
        guideRateView.trailing(to: view, offset: -12)
        
        infoRateView.topToBottom(of: guideRateView, offset: 8)
        infoRateView.leading(to: view, offset: 12)
        infoRateView.trailing(to: view, offset: -12)
        
        navigationRateView.topToBottom(of: infoRateView, offset: 8)
        navigationRateView.leading(to: view, offset: 12)
        navigationRateView.trailing(to: view, offset: -12)
        
        continueButton.topToBottom(of: navigationRateView, offset: 12)
        continueButton.leading(to: view, offset: 12)
        continueButton.trailing(to: view, offset: -12)
        continueButton.height(42)
        
        skipAnswerButton.topToBottom(of: continueButton, offset: 12)
        skipAnswerButton.leading(to: view, offset: 12)
        skipAnswerButton.trailing(to: view, offset: -12)
        skipAnswerButton.height(42)
        
    }
    
    @objc func skipAnswer() {
        dismiss(
            animated: true,
            completion: nil
        )
        viewModel.userDidTapSkipAnswer()
    }
    
    @objc func proceed() {
        dismiss(
            animated: true,
            completion: nil
        )
        viewModel.userDidTapSubmitRating()
    }

}

extension RatingSheetView: RateViewDelegate {
    func valueChanged(_ view: RateView, _ newValue: Int) {
        switch view {
        case generalRateView:
            viewModel.general = newValue
        case guideRateView:
            viewModel.guide = newValue
        case infoRateView:
            viewModel.info = newValue
        case navigationRateView:
            viewModel.navigation = newValue
        default:
            break
        }
    }
}
