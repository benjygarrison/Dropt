//
//  ViewController.swift
//  PASSWORD
//
//  Created by Benjamin Garrison on 8/31/19.
//  Copyright © 2019 Benji Garrison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var passCodeText: UITextField!
    //var passCodeDefault = ""
    //passCodeText.text = passCodeDefault
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            passCodeText.text = "1"
        case 1:
            passCodeText.text = "2"
        case 2:
            passCodeText.text = "3"
        case 3:
            passCodeText.text = "4"
        case 4:
            passCodeText.text = "5"
        case 5:
            passCodeText.text = "6"
        case 6:
            passCodeText.text = "7"
        case 7:
            passCodeText.text = "8"
        case 8:
            passCodeText.text = "9"
        case 9:
            passCodeText.text = "0"
        case 10:
            print("back")
        case 11:
            passCodeText.text = ""
        default:
            print("hubba hubba")
            
        }
    }
    
}

