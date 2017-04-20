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
    var customers: PublishSubject<CustomersListCommands.Refresh.Response> { get }
}

protocol CustomersListPresenterOutput {
    var peopleSubjects: PublishSubject<CustomersListCommands.Refresh.ViewModel> { get }
    var state: PublishSubject<ViewModelState> { get }
}

class CustomersListPresenter: CustomersListViewControllerInput {
    private let customersSubject = PublishSubject<CustomersListCommands.Refresh.ViewModel>()
    private let stateSubject = BehaviorSubject<ViewModelState>(value: .loaded)
    private let bag = DisposeBag()

    var customers: Observable<CustomersListCommands.Refresh.ViewModel> {
        get { return customersSubject.asObservable() }
    }
    var state: Observable<ViewModelState> {
        get { return stateSubject.asObservable() }
    }

    var input: CustomersListPresenterInput! {
        didSet {
            input.customers
                .share()
                .map { (response) -> ViewModelState in
                if case .loading = response {
                    return ViewModelState.loading
                }
                return ViewModelState.loaded
            }.bindTo(stateSubject).addDisposableTo(bag)

            input.customers
                .share()
                .filter { (response) -> Bool in
                    if case .success(_) = response {
                        return true
                    }
                    return false
            }.map { self.handle($0)! }
            .bindTo(customersSubject)
            .addDisposableTo(bag)
        }
    }

    private func handle(_ request: CustomersListCommands.Refresh.Response) -> CustomersListCommands.Refresh.ViewModel? {
        guard case let .success(items:i) = request else {
            return nil
        }
        let tuples = i.map {
            ($0.isGMail ? UIColor.blue : UIColor.purple, "\($0.firstName) \($0.lastName)")
        }
        return CustomersListCommands.Refresh.ViewModel(items: tuples)
    }

}
