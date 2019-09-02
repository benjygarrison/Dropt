//
//  ViewController.swift
//  PASSWORD
//
//  Created by Benjamin Garrison on 8/31/19.
//  Copyright © 2019 Benji Garrison. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class PassCodeViewController: UIViewController {
    
    @IBOutlet weak var passCodeText: UITextField!
    var passCodeDefault: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        passCodeText.text = passCodeDefault
        
    }
    
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        if let passcode = passCodeText.text {
            let saveSuccessful: Bool = KeychainWrapper.standard.set(passcode, forKey: "userPasscode")
            print("Save was successful: \(saveSuccessful)")
            self.view.endEditing(true)
        }
    }
    

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            passCodeText.text? += "1"
        case 1:
            passCodeText.text? += "2"
        case 2:
            passCodeText.text? += "3"
        case 3:
            passCodeText.text? += "4"
        case 4:
            passCodeText.text? += "5"
        case 5:
            passCodeText.text? += "6"
        case 6:
            passCodeText.text? += "7"
        case 7:
            passCodeText.text? += "8"
        case 8:
            passCodeText.text? += "9"
        case 9:
            passCodeText.text? += "0"
        case 10:
            passCodeText.text = ""
        default:
            passCodeText.text = ""
            
        }
    }
    
    
    @IBAction func checkPassCode(_ sender: UIButton) {
        let retrievedPassCode: String? = KeychainWrapper.standard.string(forKey: "userPasscode")
        print("Retrieved pass code is: \(retrievedPassCode!)")
    }
    
    
    @IBAction func deletePassCode(_ sender: UIButton) {
        let _: Bool = KeychainWrapper.standard.removeObject(forKey: "userPasscode")
        print("Pass code deleted.")    }
    
}

