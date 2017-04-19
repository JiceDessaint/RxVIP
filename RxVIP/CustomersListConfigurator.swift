//
//  CustomersListConfigurator.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 18/04/2017.
//  Copyright (c) 2017 Jean-Charles DESSAINT. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension CustomersListInteractor: CustomersListPresenterInput {
}

extension CustomersListPresenter: CustomersListViewControllerInput {
}

class CustomersListConfigurator {
    // MARK: - Object lifecycle

    static let sharedInstance = CustomersListConfigurator()

    private init() {
    }

    // MARK: - Configuration

    func configure(viewController: CustomersListViewController) {
//        let presenter = CustomersListPresenter()
//        let router = CustomerListRouter(viewController: viewController)
//        let interactor = CustomersListInteractor(customerProvider: RandomCustomerRepository(), router: router)
//
//        presenter.input = interactor
//        //viewController.input = presenter
//        viewController.output = interactor
    }
}
