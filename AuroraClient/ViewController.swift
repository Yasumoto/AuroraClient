//
//  ViewController.swift
//  AuroraClient
//
//  Created by Joseph Smith on 9/24/15.
//  Copyright © 2015 bjoli.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = AuroraAPI()
        client.getJobs()
    }
}

