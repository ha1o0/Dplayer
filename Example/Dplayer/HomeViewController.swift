//
//  HomeViewController.swift
//  Dplayer_Example
//
//  Created by sidney on 2021/7/15.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func toPlayerVc(_ sender: UIButton) {
        guard let url = Bundle.main.url(forResource: "test", withExtension: "ci.metallib") else {
            fatalError("Unable to find the required Metal shader.")
        }
        print(url)
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
