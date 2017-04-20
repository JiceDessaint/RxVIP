//
//  SwinjectStoryboard+RxVIP.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 19/04/2017.
//  Copyright © 2017 Jean-Charles DESSAINT. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        
        var arguments = ProcessInfo.processInfo.arguments
        arguments.removeFirst()
        print("App launched with the following arguments: \(arguments)")

        if arguments.contains("UseMocks") {
            defaultContainer.register(CustomerProvider.self) {_ in MockedCustomerRepository() }.inObjectScope(.container)
        } else {
            defaultContainer.register(CustomerProvider.self) {_ in RandomCustomerRepository() }.inObjectScope(.container)
        }
        
        defaultContainer.storyboardInitCompleted(CustomersListViewController.self) { r, c in
            let presenter = CustomersListPresenter()
            let router = CustomerListRouter(viewController: c)
            let customerProvider = r.resolve(CustomerProvider.self)!
            let interactor = CustomersListInteractor(customerProvider: customerProvider, router: router)
            
            presenter.input = interactor
            c.input = presenter
            c.output = interactor
        }
        
        defaultContainer.storyboardInitCompleted(CustomerDetailViewController.self) { r, c in
            let presenter = CustomerDetailPresenter()
            let interactor = CustomerDetailInteractor()
            
            presenter.input = interactor
            c.input = presenter
            c.output = interactor
        }
    }
    
}
