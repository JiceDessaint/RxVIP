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

protocol CustomersListPresenterInput {
    var customers: PublishSubject<CustomersList.Refresh.Response> { get }
}

protocol CustomersListPresenterOutput {
    var peopleSubjects: PublishSubject<CustomersList.Refresh.ViewModel> { get }
    var state: PublishSubject<ViewModelState> { get }
}

class CustomersListPresenter {
    var peoplesSubject = PublishSubject<CustomersList.Refresh.ViewModel>()
    var state = PublishSubject<ViewModelState>()
    let bag = DisposeBag()

    var input: CustomersListPresenterInput! {
        didSet {
            input.customers.asObservable().subscribe(onNext: { (response) in
                if case .loading = response {
                    self.state.onNext(.loading)
                    return
                }

                self.state.onNext(.loaded)
                guard let a = self.handle(response) else {
                    self.state.onNext(.error(message: "An error has occured"))
                    return
                }
                self.peoplesSubject.onNext(a)

            }).addDisposableTo(bag)
        }
    }

    private func handle(_ request: CustomersList.Refresh.Response) -> CustomersList.Refresh.ViewModel? {
        guard case let .success(items:i) = request else {
            return nil
        }
        let tuples = i.map {
            ($0.isGMail ? UIColor.blue : UIColor.purple, "\($0.firstName) \($0.lastName)")
        }
        return CustomersList.Refresh.ViewModel(items: tuples)
    }

}
