//
//  Customer.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 19/04/2017.
//  Copyright © 2017 Jean-Charles DESSAINT. All rights reserved.
//

import Foundation

struct Customer {
    let firstName: String
    let lastName: String
    let email: String
    var isGMail: Bool {
        get { return email.contains("gmail") }
    }
}
