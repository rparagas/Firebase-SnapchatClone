//
//  SnapsViewController.swift
//  Firebase-SnapchatClone
//
//  Created by Ray Paragas on 19/12/16.
//  Copyright © 2016 Ray Paragas. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logoutTapped(_ sender: Any) {
        print("Successfully logged out")
        dismiss(animated: true, completion: nil)
    }
}
