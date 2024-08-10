//
//  ViewController.swift
//  Tips project
//
//  Created by Student22 on 10/08/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButton(_ sender: Any) {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
}

