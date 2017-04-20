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

class MockCustomerRepository: CustomerProvider {
    
    let _customersSubject = PublishSubject<[Customer]>()
    var customers: Observable<[Customer]> {
        get { return _customersSubject.asObservable() }
    }
    
    var _resetCallsCount = 0
    func reset() {
        _resetCallsCount += 1
    }
}
