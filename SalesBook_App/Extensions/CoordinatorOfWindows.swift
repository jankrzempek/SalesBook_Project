//
//  CoordinatorOfWindows.swift
//  SalesBook_App
//
//  Created by Jan Krzempek on 03/02/2021.
//

import UIKit
//Menages screens
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

extension Coordinator {
    
    mutating func presentCoordinator(coordinator: Coordinator) {
        coordinator.start()
        childCoordinators.append(coordinator)
        navigationController.present(coordinator.navigationController, animated: true)
    }
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
//MainView
    func start() {
        let vc = MainViewController.init()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
//DetailView
    func presentDetailedView(name : String, currency: String) {
        let vc = DetailedViewController.init()
        vc.coordinator = self
        vc.passedName = name
        vc.currencyPassedSymbol = currency
        navigationController.present(vc, animated: true)
    }
//WelcomeView
    func presentWelcomeScreen() {
        let vc = WelcomeView.init()
        navigationController.present(vc, animated: true)
    }
}
