//
//  ViewController.swift
//  MLForKids
//
//  Created by Suman Sigdel on 2/6/20.
//  Copyright © 2020 Suman Sigdel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: Canvas!
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        canvasView.clearCanvas()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

