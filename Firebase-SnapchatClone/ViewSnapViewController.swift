//
//  ViewSnapViewController.swift
//  Firebase-SnapchatClone
//
//  Created by Ray Paragas on 20/12/16.
//  Copyright © 2016 Ray Paragas. All rights reserved.
//

import UIKit
import SDWebImage

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var snapImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    var snap = Snap()

    override func viewDidLoad() {
        super.viewDidLoad()
        captionLabel.text = snap.caption
        snapImageView.sd_setImage(with: URL(string: snap.imageURL))
        // Do any additional setup after loading the view.
    }
    
}
