//
//  WeatherViewController.swift
//  hw14
//
//  Created by Chernousova Maria on 03.11.2021.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    private enum Constant {
        static let animationDuration: TimeInterval = 0.3
        static let cellIdentifier = "cell"
        static let todayViewHeightAnchorMultiplier = 0.28
        static let tableViewHeightAnchorMultiplier = 0.42
        static let todayViewInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        static let todayWeatherViewInsets = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        static let descriptionViewInsets = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        static let tableViewTopInset = 10.0
    }
    
    private lazy var todayView = TodayInfoView(frame: .zero)
    private lazy var todayWeatherView = TodayWeatherView(frame: .zero)
    private lazy var tableView = UITableView(frame: .zero)
    private lazy var descriptionView = DescriptionView(frame: .zero)

    lazy var dataSource = UITableViewDiffableDataSource<Section,
                                                            DailyWeatherAdapter>(tableView: tableView) { tableView,
                                                                indexPath,
                                                                dailyWeatherAdapter in
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: Constant.cellIdentifier,
                                                       for: indexPath) as? DailyCell else { return UITableViewCell() }
        cell.configure(with: dailyWeatherAdapter)
        return cell
    }
    
    private let viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupAutoLayout()
        
        viewModel.load()
    }
    
    private func setupSubviews() {
        view.addSubview(todayView)
        view.addSubview(todayWeatherView)
        view.addSubview(tableView)
        view.addSubview(descriptionView)

        tableView.separatorStyle = .none
        tableView.dataSource = dataSource
        tableView.allowsSelection = false
        tableView.bounces = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(DailyCell.self,
                           forCellReuseIdentifier: Constant.cellIdentifier)
        
        view.backgroundColor = .systemBackground

    }
    
    private func setupAutoLayout() {
        todayView.translatesAutoresizingMaskIntoConstraints = false
        todayWeatherView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todayView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor,
                                              multiplier: Constant.todayViewHeightAnchorMultiplier),
            todayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: Constant.todayViewInsets.top),
            todayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: Constant.todayViewInsets.left),
            todayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -Constant.todayViewInsets.right),

            todayWeatherView.topAnchor.constraint(equalTo: todayView.bottomAnchor,
                                                  constant: Constant.todayWeatherViewInsets.top),
            todayWeatherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: Constant.todayWeatherViewInsets.left),
            todayWeatherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -Constant.todayWeatherViewInsets.right),

            tableView.topAnchor.constraint(equalTo: todayWeatherView.bottomAnchor,
                                           constant: Constant.tableViewTopInset),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            descriptionView.topAnchor.constraint(equalTo: tableView.bottomAnchor,
                                                 constant: Constant.descriptionViewInsets.top),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: Constant.descriptionViewInsets.left),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: -Constant.descriptionViewInsets.bottom),
            descriptionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                    constant: -Constant.descriptionViewInsets.right)
        ])
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    func update(with adapter: TodayInfoAdapter) {
        UIView.animate(withDuration: Constant.animationDuration) {
            self.todayView.configure(with: adapter)
        }
    }
    
    func update(with adapter: TodayWeatherAdapter) {
        UIView.animate(withDuration: Constant.animationDuration) {
            self.todayWeatherView.configure(with: adapter)
        }
    }
    
    func update(with adapters: [DailyWeatherAdapter]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DailyWeatherAdapter>()
        snapshot.appendSections([.main])
        snapshot.appendItems(adapters, toSection: .main)
        dataSource.apply(snapshot)
    }
    
    func update(with adapter: DescriptionWeatherAdapter) {
        UIView.animate(withDuration: Constant.animationDuration) {
            self.descriptionView.configure(with: adapter)
        }
    }
}


