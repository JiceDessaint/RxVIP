//
//  CustomersListViewController.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 18/04/2017.
//  Copyright (c) 2017 Jean-Charles DESSAINT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomerDetailInteractor: CustomerDetailViewControllerOutput, CustomerDetailPresenterInput {
   
    var customer = PublishSubject<Customer>()

    func load(customer: Customer) {
        self.customer.onNext(customer)
    }
}
