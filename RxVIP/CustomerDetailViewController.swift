//
//  CustomerDetailViewController.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 19/04/2017.
//  Copyright © 2017 Jean-Charles DESSAINT. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol CustomerDetailViewControllerOutput {
    func load(customer: Customer)
}

protocol CustomerDetailViewControllerInput {
    var customerInfos: PublishSubject<CustomerDetail.ViewModel> { get }

}

class CustomerDetailViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!

    var input: CustomerDetailViewControllerInput!
    var output: CustomerDetailViewControllerOutput!
    let bag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        CustomerDetailConfigurator.sharedInstance.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInput()
        configureOutput()
    }
    
    private func configureOutput() {
        closeButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.dismiss(animated: true)
        }).addDisposableTo(bag)
    }
    
    private func configureInput() {
        input.customerInfos.subscribe(onNext: { viewModel in
            self.configureWith(viewModel: viewModel)
        }).addDisposableTo(bag)
    }
    
    private func configureWith(viewModel: CustomerDetail.ViewModel) {
        colorView.backgroundColor = viewModel.color
        firstNameLabel.text = viewModel.firstName
        lastNameLabel.text = viewModel.lastName
        emailLabel.text = viewModel.email
    }

}
