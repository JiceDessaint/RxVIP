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
    var customer: Observable<Customer> { get }
}

protocol CustomerDetailPresenterOutput {
    var customerInfos: Observable<CustomerDetail.ViewModel> { get }
}

class CustomerDetailPresenter: CustomerDetailViewControllerInput {
    private let customerInfosSubject = PublishSubject<CustomerDetail.ViewModel>()
    private let bag = DisposeBag()
    
    var customerInfos: Observable<CustomerDetail.ViewModel> {
        get { return customerInfosSubject.asObservable() }
    }
    
    var input: CustomerDetailPresenterInput! {
        didSet {
            input.customer
                .map(handle)
                .bindTo(customerInfosSubject)
                .addDisposableTo(bag)
        }
    }

    private func handle(_ model: Customer) -> CustomerDetail.ViewModel {
        return CustomerDetail.ViewModel(color: UIColor.gray, firstName: model.firstName, lastName: model.lastName, email: model.email)
    }
}
