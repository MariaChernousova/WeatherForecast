//
//  SceneDelegate.swift
//  hw14
//
//  Created by Chernousova Maria on 03.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let apiService = ApiService()
        let model = WeatherModel(apiService: apiService)
        let viewModel = WeatherViewModel(model: model)
        let viewController = WeatherViewController(viewModel: viewModel)
        
        viewModel.delegate = viewController
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

