//
//  Observables+Utils.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 19/04/2017.
//  Copyright © 2017 Jean-Charles DESSAINT. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
    public func delay(time: TimeInterval, scheduler: SchedulerType = MainScheduler.instance) -> Observable<E> {
        return self.flatMap { element in
            Observable<Int>.timer(time, scheduler: scheduler)
                .map { _ in
                    return element
            }
        }
    }
}
