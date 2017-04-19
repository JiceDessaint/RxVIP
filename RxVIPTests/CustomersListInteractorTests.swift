//
//  CustomersListInteractorTests.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 19/04/2017.
//  Copyright © 2017 Jean-Charles DESSAINT. All rights reserved.
//

import XCTest
import RxSwift

@testable import RxVIP

class CustomersListInteractorTests: XCTestCase {
    
    let bag = DisposeBag()
    var interactor: CustomersListInteractor!
    var mockRepository = MockCustomerRepository()
    var capturedCustomers = Array<CustomersList.Refresh.Response>()
    
    override func setUp() {
        super.setUp()
        interactor = CustomersListInteractor(customerProvider: mockRepository)
        interactor.customers.subscribe(onNext: { (response) in
            self.capturedCustomers.append(response)
        }).addDisposableTo(bag)
    }
    
    // MARK: Initialization Tests --
    
    func test_init_shouldBindRepositoryToOutput() {
        // Arrange
        let pushedCustomers = [
            Customer(firstName: "A", lastName: "AA", isGMail: true),
            Customer(firstName: "B", lastName: "BB", isGMail: false)
        ]
        // Act
        mockRepository._customersSubject.onNext(pushedCustomers)
        // Assert
        guard let lastEmittedCustomers = capturedCustomers.first, case let .success(items) = lastEmittedCustomers else {
            XCTFail("Output is empty or not success")
            return
        }
        XCTAssertEqual(2, items.count)
        XCTAssertEqual("A", items[0].firstName)
        XCTAssertEqual("B", items[1].firstName)
    }
    
    // MARK: Reset Tests --
    
    func test_reset_shouldInitiateLoadingState() {
        // Act
        interactor.refresh()
        // Assert
        guard let lastEmittedCustomers = capturedCustomers.first, case .loading = lastEmittedCustomers else {
            XCTFail("Output is empty or not loading")
            return
        }
    }

    func test_reset_shouldResetRepository() {
        // Act
        interactor.refresh()
        // Assert
        XCTAssertEqual(1, mockRepository._resetCallsCount)
    }

}
