//
//  CommentSheetView.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 12.07.2024.
//

import UIKit
import Combine

class CommentSheetView: UIViewController {
    
    init(viewModel: CommentSheetViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewModel: CommentSheetViewModel
    private var cancellables = Set<AnyCancellable>()
    
    let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image =  UIImage(systemName: "person.crop.circle")!
        return view
    }()
    
    let reviewLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.text = Constants.CommentSheetViewStrings.reviewLabel
        view.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    let reviewTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .justified
        view.text = Constants.CommentSheetViewStrings.placeholderText
        return view
    }()
    
    let suggestionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.text = Constants.CommentSheetViewStrings.suggestionLabel
        view.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    let suggestionTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .lightGray
        view.textAlignment = .justified
        view.font = .systemFont(ofSize: 14)
        view.text = Constants.CommentSheetViewStrings.placeholderText
        return view
    }()
    
    let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.CommentSheetViewStrings.continueButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(proceed), for: .touchUpInside)
        return button
    }()
    
    let skipAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.CommentSheetViewStrings.skipAnswerButton, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(skipAnswer), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        reviewTextView.delegate = self
        suggestionTextView.delegate = self
        
        binding()
        
        setupConstraints()
        setupKeyboardHiding()
        
    }
    
    private func setupKeyboardHiding() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupConstraints() {
        view.addSubview(avatarImageView)
        view.addSubview(reviewLabel)
        view.addSubview(reviewTextView)
        view.addSubview(suggestionLabel)
        view.addSubview(suggestionTextView)
        view.addSubview(continueButton)
        view.addSubview(skipAnswerButton)
        
        avatarImageView.height(80)
        avatarImageView.width(80)
        avatarImageView.top(to: view, offset: 16)
        avatarImageView.leading(to: view, offset: 12)
        
        reviewLabel.leading(to: view, offset: 12)
        reviewLabel.trailing(to: view, offset: -12)
        reviewLabel.topToBottom(of: avatarImageView, offset: 16)
        
        reviewTextView.topToBottom(of: reviewLabel, offset: 4)
        reviewTextView.height(70)
        reviewTextView.leading(to: view, offset: 12)
        reviewTextView.trailing(to: view, offset: -12)
        
        suggestionLabel.topToBottom(of: reviewTextView, offset: 12)
        suggestionLabel.leading(to: view, offset: 12)
        suggestionLabel.trailing(to: view, offset: -12)
        
        suggestionTextView.topToBottom(of: suggestionLabel, offset: 4)
        suggestionTextView.height(70)
        suggestionTextView.leading(to: view, offset: 12)
        suggestionTextView.trailing(to: view, offset: -12)
        
        continueButton.topToBottom(of: suggestionTextView, offset: 12)
        continueButton.leading(to: view, offset: 12)
        continueButton.trailing(to: view, offset: -12)
        continueButton.height(42)
        
        skipAnswerButton.topToBottom(of: continueButton, offset: 12)
        skipAnswerButton.leading(to: view, offset: 12)
        skipAnswerButton.trailing(to: view, offset: -12)
        skipAnswerButton.height(42)
        
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
    
    @objc func skipAnswer() {
        dismiss(
            animated: true,
            completion: nil
        )
    }
    
    @objc func proceed() {
        reviewTextView.endEditing(true)
        suggestionTextView.endEditing(true)
        viewModel.userDidTapSubmitComment()
        dismiss(
            animated: true,
            completion: nil
        )
    }

}

extension CommentSheetView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            textView.textColor = .lightGray
            textView.text = Constants.CommentSheetViewStrings.placeholderText
            return
        }
        switch textView {
        case reviewTextView:
            viewModel.review = textView.text!
        case suggestionTextView:
            viewModel.suggestion = textView.text!
        default:
            break
        }
    }
}
