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

protocol CustomersListViewControllerInput {
    var customers: Observable<CustomersListCommands.Refresh.ViewModel> { get }
    var state: Observable<ViewModelState> { get }
}

protocol CustomersListViewControllerOutput {
    func refresh()
    func showDetailForCell(request: CustomersListCommands.ShowDetail.Request)
}


class CustomersListViewController: UIViewController {
    var input: CustomersListViewControllerInput!
    var output: CustomersListViewControllerOutput!
    private let disposeBag = DisposeBag()

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var peopleTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutput()
        configureInput()
    }

    private func configureOutput() {
        refreshButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.output.refresh()
        }).addDisposableTo(disposeBag)
        peopleTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            let request = CustomersListCommands.ShowDetail.Request(indexPath: indexPath)
            self.output.showDetailForCell(request: request)
        }).addDisposableTo(disposeBag)
    }

    private func configureInput() {
        input.customers
            .map { $0.items }
            .bindTo(peopleTableView.rx.items(cellIdentifier: "customerCell", cellType: CustomerCell.self)) { (_, element, cell) in
                    cell.configure(color: element.0, name: element.1)
            }
            .addDisposableTo(disposeBag)

        input.state.subscribe(onNext: { state in
            switch state {
            case let .error(message):
                print("error: \(message)") // UI Popup
            case .loading:
                self.activityIndicator.startAnimating()
            default:
                self.activityIndicator.stopAnimating()
            }
            })
            .addDisposableTo(disposeBag)
    }


}
