//
// Created by Jean-Charles DESSAINT on 19/04/2017.
// Copyright (c) 2017 Jean-Charles DESSAINT. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerListRouterInput {
    func navigateToDetail(for customer: Customer)
}

struct CustomerListRouter: CustomerListRouterInput {
    
    var viewController: UIViewController

    func navigateToDetail(for customer: Customer) {
         let storyboard = UIStoryboard(name: "CustomerDetail", bundle: nil)
         let detailViewController = storyboard.instantiateInitialViewController() as! CustomerDetailViewController
         viewController.present(detailViewController, animated: true)
        detailViewController.output.load(customer: customer)
    
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
