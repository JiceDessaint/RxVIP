//
//  MockCustomerRepository.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 19/04/2017.
//  Copyright © 2017 Jean-Charles DESSAINT. All rights reserved.
//

import XCTest
import RxSwift

@testable import RxVIP

class MockCustomerListRouter: CustomerListRouterInput {

    var capturedNavigateToDetail = [Customer]()
    func navigateToDetail(for customer: Customer) {
        capturedNavigateToDetail.append(customer)
    }

}
