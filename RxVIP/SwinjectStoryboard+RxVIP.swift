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
        defaultContainer.storyboardInitCompleted(CustomersListViewController.self) { r, c in
            let presenter = CustomersListPresenter()
            let router = CustomerListRouter(viewController: c)
            let interactor = CustomersListInteractor(customerProvider: RandomCustomerRepository(), router: router)
            
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
