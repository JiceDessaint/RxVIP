//
//  CustomerRepository.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 19/04/2017.
//  Copyright © 2017 Jean-Charles DESSAINT. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

protocol CustomerProvider {
    var customers: Observable<[Customer]> { get }
    func reset()
}

struct RandomCustomerRepository: CustomerProvider {
    
    private let customersSubject = PublishSubject<[Customer]>()
    private let bag = DisposeBag()
    var customers: Observable<[Customer]> {
        get { return customersSubject.asObservable() }
    }
    
    func reset() {
        let url = "https://randomapi.com/api/6de6abfedb24f889e0b5f675edc50deb?fmt=raw&sole"
        RxAlamofire
            .requestJSON(.get, url)
            .observeOn(MainScheduler.instance)
            .delay(time: 2)
            .map { (response, json) -> [Customer] in
                self.parseJSON(json: json as AnyObject)
            }.subscribe(onNext: { (customers) in
                self.customersSubject.onNext(customers)
            }).addDisposableTo(bag)
    }
    
    private func parseJSON(json: AnyObject) -> [Customer] {
        guard let items = json as? [Dictionary<String, AnyObject>] else {
            return []
        }
        return items.prefix(upTo: 10).map { (dict) -> Customer in
            return Customer(
                firstName: dict["first"] as! String,
                lastName: dict["last"] as! String,
                email: dict["email"] as! String)
            
        }
    }
}

struct  MockedCustomerRepository: CustomerProvider {
    private let customersSubject = PublishSubject<[Customer]>()
    private let bag = DisposeBag()
    var customers: Observable<[Customer]> {
        get { return customersSubject.asObservable() }
    }
    
    func reset() {
        let customers = [
            Customer(firstName: "Mark", lastName: "Zalzendorf", email: "marko@gmail.com"),
            Customer(firstName: "Richard", lastName: "Brendan", email: "richard@gmail.com"),
            Customer(firstName: "Zoe", lastName: "Charles", email: "zoe@yahoo.fr"),
            Customer(firstName: "Ron", lastName: "Harris", email: "ron@outlook.fr"),
        ]
        self.customersSubject.onNext(customers)
    }
}
