//
//  TodayWeatherView.swift
//  hw14
//
//  Created by Chernousova Maria on 07.11.2021.
//

import UIKit

final class TodayWeatherView: UIView {
    private enum Constant {
        static let dateLabelFontSize = 18.0
        static let titleLabelFontSize = 18.0
        static let verticalSpacing = 2.0
        static let horizontalSpacing = 8.0
    }

    lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline),
                            size: Constant.dateLabelFontSize)
        return label
    }()
    
    private lazy var todayLabel = UILabel(frame: .zero)
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, todayLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = Constant.verticalSpacing
        return stackView
    }()
    
    lazy var todayDayTemperatureLabel = UILabel(frame: .zero)
    
    lazy var todayNightTemperatureLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var tempStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [todayDayTemperatureLabel,
                                                       todayNightTemperatureLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = Constant.horizontalSpacing
        return stackView
    }()
    
    private lazy var todayCellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateStackView, tempStackView])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = Constant.horizontalSpacing
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
    
    func configure(with adapter: TodayWeatherAdapter) {
        dateLabel.text = adapter.date
        todayLabel.text = adapter.today
        todayDayTemperatureLabel.text = adapter.dayTemperature
        todayNightTemperatureLabel.text = adapter.nightTemperature
    }
    
    private func setupSubviews() {
        addSubview(todayCellStackView)
    }
    
    private func setupAutoLayout() {
        todayCellStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todayCellStackView.topAnchor.constraint(equalTo: topAnchor),
            todayCellStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            todayCellStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            todayCellStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
