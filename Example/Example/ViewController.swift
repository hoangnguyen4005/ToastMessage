//
//  ViewController.swift
//  Example
//
//  Created by Chi Hoang on 30/4/20.
//  Copyright © 2020 Hoang Nguyen Chi. All rights reserved.
//

import UIKit
import ToastMessage

class ViewController: UIViewController {
    @IBOutlet weak var successButton: UIButton!
    @IBOutlet weak var warningButton: UIButton!
    @IBOutlet weak var failureButton: UIButton!
    let message = "Answers to questions are incorrect. Please try again or tap on Forgot Answers."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.successButton.setTitle("Success Toast", for: .normal)
        self.warningButton.setTitle("Warning Toast", for: .normal)
        self.failureButton.setTitle("Failure Toast", for: .normal)
    }

    @IBAction func clickSuccess(_ sender: Any) {
        ToastMessages.shared.show(messge: message,
                                     type: .success,
                                     from: self)
    }
    @IBAction func clickWarning(_ sender: Any) {
        ToastMessages.shared.show(messge: message,
                                     type: .warning,
                                     from: self)
    }
    @IBAction func clickFailure(_ sender: Any) {
        ToastMessages.shared.show(messge: message,
                                     type: .failure,
                                     from: self)
    }
}
