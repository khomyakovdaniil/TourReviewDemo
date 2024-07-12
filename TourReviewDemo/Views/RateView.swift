//
//  RateView.swift
//  TourReviewDemo
//
//  Created by  Даниил Хомяков on 11.07.2024.
//

import UIKit
import StepSlider

protocol RateViewDelegate: AnyObject {
    func valueChanged(_ view: RateView,_ newValue: Int) -> Void
}

class RateView: UIView {
    
    let label: UILabel = {
        let view = UILabel()
        view.text = ""
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let slider: StepSlider = {
        let view = StepSlider()
        view.maxCount = 5
        view.index = 2
        view.tintColor = .gray
        view.trackHeight = 1
        view.trackCircleRadius = 4
        view.dropShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(nil, action: #selector(handleSliderValue), for: .valueChanged)
        return view
    }()
    
    let emoji: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image =  UIImage(named: "rate3")!
        return view
    }()
    
    weak var delegate: RateViewDelegate?
    
    convenience init(text: String) {
        self.init()
        label.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(label)
        self.addSubview(slider)
        self.addSubview(emoji)
        
        label.top(to: self)
        label.leading(to: self, offset: 6)
        slider.topToBottom(of: label, offset: 18)
        slider.trailing(to: self)
        slider.leading(to: self)
        slider.bottom(to: self)
        emoji.height(24)
        emoji.width(24)
        emoji.trailing(to: self, offset: -6)
        emoji.top(to: self)
        
    }
    
    private func getImageFor(index: Int) -> UIImage {
        switch index {
        case 0:
            UIImage(named: "rate1")!
        case 1:
            UIImage(named: "rate2")!
        case 3:
            UIImage(named: "rate4")!
        case 4:
            UIImage(named: "rate5")!
        default:
            UIImage(named: "rate3")!
        }
    }
    
    @objc func handleSliderValue() {
        let value = Int(slider.index)
        emoji.image = getImageFor(index: value)
        delegate?.valueChanged(self, value)
    }
}
