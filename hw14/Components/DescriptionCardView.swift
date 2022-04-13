//
//  DescriptionCardView.swift
//  hw14
//
//  Created by Chernousova Maria on 04.11.2021.
//

import UIKit

final class DescriptionCardView: UIView {
    private enum Constant {
        static let titleLabelFontSize = 18.0
        static let verticalSpacing = 2.0
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.headlineFont(ofSize: Constant.titleLabelFontSize)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var descriptionCellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       descriptionLabel])
        stackView.distribution = .fillProportionally
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
    
    private func setupSubviews() {
        addSubview(descriptionCellStackView)
    }
    
    private func setupAutoLayout() {
        descriptionCellStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionCellStackView.topAnchor.constraint(equalTo: topAnchor),
            descriptionCellStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionCellStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            descriptionCellStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension UIFont {

    class func headlineFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline),
                            size: size)
    }
}
