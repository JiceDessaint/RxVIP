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

class CustomersListInteractor: CustomersListViewControllerOutput, CustomersListPresenterInput {
    private let repository: CustomerProvider
    private let bag = DisposeBag()
    private let router: CustomerListRouterInput
    private var hackCustomers = [Customer]() // Little hack to go faster (copy customers when sequence is refreshed)
    
    let customers = PublishSubject<CustomersListCommands.Refresh.Response>()

    init(customerProvider: CustomerProvider, router: CustomerListRouterInput) {
        repository = customerProvider
        self.router = router
        
        repository.customers
            .share()
            .map { CustomersListCommands.Refresh.Response.success(items: $0) }
            .subscribe(onNext: { (response) in
                    self.customers.onNext(response)
            })
            .addDisposableTo(bag)
        
        repository.customers
            .share()
            .subscribe(onNext: { (customers) in
                self.hackCustomers = customers
            })
            .addDisposableTo(bag)
    }

    func refresh() {
        customers.onNext(CustomersListCommands.Refresh.Response.loading)
        repository.reset()
    }
    
    func showDetailForCell(request: CustomersListCommands.ShowDetail.Request) {
        router.navigateToDetail(for: hackCustomers[request.indexPath.row])
    }

}
