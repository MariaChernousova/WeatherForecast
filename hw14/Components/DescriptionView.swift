//
//  DescriptionView.swift
//  hw14
//
//  Created by Chernousova Maria on 07.11.2021.
//

import UIKit

final class DescriptionView: UIView {
    private enum Constant {
        static let verticalSpacing = 2.0
        static let horizontalSpacing = 8.0
    }
    
    lazy var sunriseView = DescriptionCardView(frame: .zero)
    lazy var sunsetView = DescriptionCardView(frame: .zero)
    lazy var windSpeedView = DescriptionCardView(frame: .zero)
    lazy var humidityView = DescriptionCardView(frame: .zero)
    
    private lazy var firstRowStackView = configureStackView([sunriseView, sunsetView])
    private lazy var secondRowStackView = configureStackView([windSpeedView, humidityView])
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstRowStackView,
                                                       secondRowStackView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = Constant.verticalSpacing
        return stackView
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
    
    func configure(with adapter: DescriptionWeatherAdapter) {
        sunriseView.titleLabel.text = adapter.sunriseTitle
        sunsetView.titleLabel.text = adapter.sunsetTitle
        windSpeedView.titleLabel.text = adapter.windSpeedTitle
        humidityView.titleLabel.text = adapter.humidityTitle
        
        sunriseView.descriptionLabel.text = adapter.sunrise
        sunsetView.descriptionLabel.text = adapter.sunset
        windSpeedView.descriptionLabel.text = adapter.windSpeed
        humidityView.descriptionLabel.text = adapter.humidity
    }
    
    private func setupSubviews() {
        addSubview(containerStackView)
    }
    
    private func setupAutoLayout() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureStackView(_ arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = Constant.horizontalSpacing
        return stackView
    }
}
