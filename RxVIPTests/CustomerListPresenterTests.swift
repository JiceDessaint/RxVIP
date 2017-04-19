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

class CustomersListPresenterTests: XCTestCase {
    
    let bag = DisposeBag()
    var presenter: CustomersListPresenter!
    var mockInteractor = MockCustomerListInteractor()
    
    var capturedCustomers = Array<CustomersList.Refresh.ViewModel>()
    var capturedStates = [ViewModelState]()
    
    override func setUp() {
        super.setUp()
        presenter = CustomersListPresenter()
        presenter.input = mockInteractor
        presenter.peoplesSubject.asObservable().subscribe(onNext: { viewModel in
                self.capturedCustomers.append(viewModel)
        }).addDisposableTo(bag)
        presenter.state.asObservable().subscribe(onNext: { state in
            self.capturedStates.append(state)
        }).addDisposableTo(bag)
    }
    
    // MARK: Initialization Tests --
    
    func test_init_shouldBindInteractorToStateLoading_whenReceivingLoadingState() {
        // Act
        mockInteractor.customers.onNext(.loading)
        // Assert
        XCTAssertEqual(0, capturedCustomers.count)
        XCTAssertEqual(1, capturedStates.count)
        XCTAssertEqual(String(describing: ViewModelState.loading), String(describing: capturedStates[0]))
    }

    func test_init_shouldBindInteractorToStateLoaded_whenReceivingData() {
        // Act
        let customer = Customer(firstName: "A", lastName: "AA", isGMail: true)
        mockInteractor.customers.onNext(.success(items: [customer]))
        // Assert
        XCTAssertEqual(1, capturedStates.count)
        XCTAssertEqual(String(describing: ViewModelState.loaded), String(describing: capturedStates[0]))
    }

    func test_init_shouldBindInteractorToCustomers_whenReceivingData() {
        // Act
        let customer = Customer(firstName: "A", lastName: "AA", isGMail: true)
        mockInteractor.customers.onNext(.success(items: [customer]))
        // Assert
        XCTAssertEqual(1, capturedCustomers.count)
    }
    
    // MARK: Model to ViewModel Tests

    func test_handle_shouldTransformUserNameFull() {
        // Act
        let customer = Customer(firstName: "A", lastName: "AA", isGMail: true)
        mockInteractor.customers.onNext(.success(items: [customer]))
        // Arrange
        XCTAssertEqual("A AA", capturedCustomers[0].items[0].1)
    }

    func test_handle_shouldReturnBlueColorViewModel_whenCustomerIsGmail() {
        // Act
        let customer = Customer(firstName: "A", lastName: "AA", isGMail: true)
        mockInteractor.customers.onNext(.success(items: [customer]))
        // Assert
        XCTAssertEqual(UIColor.blue, capturedCustomers[0].items[0].0)
    }

    func test_handle_shouldReturnPurpleColorViewModel_whenCustomerIsNotGmail() {
        // Act
        let customer = Customer(firstName: "A", lastName: "AA", isGMail: false)
        mockInteractor.customers.onNext(.success(items: [customer]))
        // Assert
        XCTAssertEqual(UIColor.purple, capturedCustomers[0].items[0].0)
    }
    
    func test_handle_shouldReturnNil_whenUnableToTransformData() {
        // Arrange
        class MyError: Error {}
        // Act
        mockInteractor.customers.onNext(.error(error: MyError()))
        // Assert
        XCTAssertEqual(2, capturedStates.count)
        let lastState = capturedStates[1]
        XCTAssertEqual(String(describing: ViewModelState.error(message: "An error has occured")), String(describing: lastState))
    }
    
    
}
