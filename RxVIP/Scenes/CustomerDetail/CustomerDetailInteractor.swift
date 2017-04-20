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
   
    private let customerSubject = PublishSubject<Customer>()

    var customer: Observable<Customer> {
        get { return customerSubject.asObservable() }
    }
    
    func load(customer: Customer) {
        self.customerSubject.onNext(customer)
    }
}
