//
//  DailyCell.swift
//  hw14
//
//  Created by Chernousova Maria on 04.11.2021.
//

import UIKit

final class DailyCell: UITableViewCell {
    private enum Constant {
        static let horizontalSpacing = 8.0
        static let dayLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 0)
        static let conditionStateImageViewWidth = 50.0
        static let conditionStateImageViewInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        static let temperatureStackViewInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 20)
    }
    
    private lazy var dayLabel = UILabel(frame: .zero)
    private lazy var conditionStateImageView = UIImageView(frame: .zero)
    
    private lazy var dayTemperatureLabel = UILabel(frame: .zero)
    private lazy var nightTemperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var temperatureStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            dayTemperatureLabel,
            nightTemperatureLabel
        ])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = Constant.horizontalSpacing
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func configure(with adapter: DailyWeatherAdapter) {
        dayLabel.text = adapter.day
        conditionStateImageView.loadImage(from: adapter.conditionImageURL)
        dayTemperatureLabel.text = adapter.dayTemperature
        nightTemperatureLabel.text = adapter.nightTemperature
    }
    
    private func commonInit() {
        setupSubviews()
        setupAutoLayout()
    }
    
    private func setupSubviews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(conditionStateImageView)
        contentView.addSubview(temperatureStackView)
    }
    
    private func setupAutoLayout() {
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionStateImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: Constant.dayLabelInsets.top),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                              constant: Constant.dayLabelInsets.left),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                             constant: -Constant.dayLabelInsets.bottom),
            
            conditionStateImageView.widthAnchor.constraint(equalToConstant: Constant.conditionStateImageViewWidth),
            conditionStateImageView.heightAnchor.constraint(equalTo: conditionStateImageView.widthAnchor),
            conditionStateImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            conditionStateImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                         constant: Constant.conditionStateImageViewInsets.top),
            conditionStateImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                            constant: -Constant.conditionStateImageViewInsets.bottom),
            
            temperatureStackView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                      constant: Constant.temperatureStackViewInsets.top),
            temperatureStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                         constant: -Constant.temperatureStackViewInsets.bottom),
            temperatureStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                           constant: -Constant.temperatureStackViewInsets.right)
        ])
    }
}

