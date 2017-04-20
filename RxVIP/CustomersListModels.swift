//
//  CustomersListViewController.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 18/04/2017.
//  Copyright (c) 2017 Jean-Charles DESSAINT. All rights reserved.
//

import UIKit

enum ViewModelState {
    case loading
    case loaded
    case error(message: String)
}

struct CustomersListCommands {

    struct Refresh {
        struct Request { // Keep it for example of a request with parameters
        }

        enum Response {
            case success(items: [Customer])
            case loading
            case error(error: Error)
        }
        struct ViewModel {
            let items: [(UIColor, String)]
        }
    }
    
    struct ShowDetail {
        struct Request {
            let indexPath: IndexPath
        }
    }

}
