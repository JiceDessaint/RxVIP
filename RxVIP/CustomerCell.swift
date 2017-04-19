//
//  CustomerCell.swift
//  RxVIP
//
//  Created by Jean-Charles DESSAINT on 19/04/2017.
//  Copyright © 2017 Jean-Charles DESSAINT. All rights reserved.
//

import Foundation
import UIKit

class CustomerCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!

    func configure(color: UIColor, name: String) {
        self.nameLabel.text = name
        self.colorView.backgroundColor = color
    }
}
