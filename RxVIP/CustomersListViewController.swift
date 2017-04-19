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
    var peoplesSubject: PublishSubject<CustomersList.Refresh.ViewModel> { get }
    var state: PublishSubject<ViewModelState> { get }
}

protocol CustomersListViewControllerOutput {
    func refresh()
    func showDetailForCell(at index:IndexPath)
}


class CustomersListViewController: UIViewController {
    var input: CustomersListViewControllerInput!
    var output: CustomersListViewControllerOutput!
    let disposeBag = DisposeBag()

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var peopleTableView: UITableView!

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        CustomersListConfigurator.sharedInstance.configure(viewController: self) // TODO
//    }

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
            self.output.showDetailForCell(at: indexPath)
        }).addDisposableTo(disposeBag)
    }

    private func configureInput() {
        input.peoplesSubject
                .asObservable()
                .map {
                    $0.items
                }
                .bindTo(peopleTableView.rx.items(cellIdentifier: "customerCell", cellType: CustomerCell.self)) { (_, element, cell) in
                    cell.configure(color: element.0, name: element.1)
                }.addDisposableTo(disposeBag)

        input.state.asObservable().subscribe(onNext: { state in
            switch state {
            case let .error(message):
                print("error: \(message)") // UI Popup
            case .loading:
                self.activityIndicator.startAnimating()
            default:
                self.activityIndicator.stopAnimating()
            }
        }).addDisposableTo(disposeBag)
    }


}
