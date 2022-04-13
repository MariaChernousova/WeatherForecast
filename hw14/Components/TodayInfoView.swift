//
//  TodayInfoView.swift
//  hw14
//
//  Created by Chernousova Maria on 04.11.2021.
//

import UIKit

final class TodayInfoView: UIView {
    private enum Constant {
        static let cityLabelFontSize = 26.0
        static let todayTemperatureLabelFontSize = 48.0
        static let conditionLabelTopAnchor = 2.0
        static let conditionImageViewSize = CGSize(width: 84, height: 84)
        static let conditionImageViewTopInset = 8.0
        static let todayTemperatureLabelTopInset = 8.0
    }
    
    lazy var cityNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline),
                            size: Constant.cityLabelFontSize)
        return label
    }()
    
    lazy var conditionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .systemGray
        return label
    }()
    
    lazy var conditionImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var todayTemperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body),
                            size: Constant.todayTemperatureLabelFontSize)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupAutoLayout()
    }
    
    func configure(with adapter: TodayInfoAdapter) {
        cityNameLabel.text = adapter.cityName
        conditionLabel.text = adapter.conditionText
        conditionImageView.loadImage(from: adapter.conditionImageURL)
        todayTemperatureLabel.text = adapter.todayTemperature
    }
    
    private func setupSubviews() {
        addSubview(cityNameLabel)
        addSubview(conditionLabel)
        addSubview(conditionImageView)
        addSubview(todayTemperatureLabel)
    }
    
    private func setupAutoLayout() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        todayTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor),
            
            conditionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            conditionLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor,
                                                constant: Constant.conditionLabelTopAnchor),
            
            conditionImageView.heightAnchor.constraint(lessThanOrEqualToConstant: Constant.conditionImageViewSize.height),
            conditionImageView.widthAnchor.constraint(equalToConstant: Constant.conditionImageViewSize.width),
            conditionImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            conditionImageView.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor,
                                                    constant: Constant.conditionImageViewTopInset),

            todayTemperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            todayTemperatureLabel.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor,
                                                       constant: Constant.todayTemperatureLabelTopInset),
            todayTemperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
