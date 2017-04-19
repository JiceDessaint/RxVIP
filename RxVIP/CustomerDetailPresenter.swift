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

protocol CustomerDetailPresenterInput {
    var customer: PublishSubject<Customer> { get }
}

protocol CustomerDetailPresenterOutput {
    var customerInfos: PublishSubject<CustomerDetail.ViewModel> { get }
}

class CustomerDetailPresenter: CustomerDetailViewControllerInput {
    var customerInfos = PublishSubject<CustomerDetail.ViewModel>()
    let bag = DisposeBag()
    
    var input: CustomerDetailPresenterInput! {
        didSet {
            input.customer.asObservable().map(handle).bindTo(customerInfos).addDisposableTo(bag)
        }
    }

    private func handle(_ model: Customer) -> CustomerDetail.ViewModel {
        return CustomerDetail.ViewModel(color: UIColor.gray, firstName: model.firstName, lastName: model.lastName, email: model.email)
    }
}
