//
//  MockCustomersListInteractor.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 19/04/2017.
//  Copyright © 2017 Jean-Charles DESSAINT. All rights reserved.
//

import Foundation
import RxSwift
@testable import RxVIP

class MockCustomerListInteractor: CustomersListPresenterInput {
    var customers = PublishSubject<CustomersListCommands.Refresh.Response>()
}
