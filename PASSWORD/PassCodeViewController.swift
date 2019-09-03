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
    
    //Variables
    
    @IBOutlet weak var AlarmView: UIView!
    @IBOutlet weak var passCodeText: UITextField!
    var passCodeDefault: String = ""
    @IBOutlet weak var passCodeLabel: UILabel!
    @IBOutlet weak var enter: UIButton!
    
    let currentPassCode: String? = KeychainWrapper.standard.string(forKey: "userPasscode")
    var firstInput: String?
    var secondInput: String?
    
    
    
    
    //View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enter.tag = 12

        if (currentPassCode != nil) {
            passCodeLabel.text = "Please enter your passcode."
        }
        else {
            passCodeLabel.text = "Please create a 4-digit passcode."
        }
        
        passCodeText.text = passCodeDefault
    }
    
    

    
    //Actions
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        
        //create passcode
        if (currentPassCode == nil && enter.tag == 12) {
            createPassCode()
        } else if (currentPassCode == nil && enter.tag == 11)  {
            confirmPassCode()
        }
        
        //password entered function
        if (currentPassCode != nil) {
            passCodeExists()
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
        print("Pass code deleted.")
    }
    
    
    
    
    //Functions (TODO: move to Model files?)
    
    func passCodeExists() {
        let retrievedPassCode: String? = KeychainWrapper.standard.string(forKey: "userPasscode")
        if (passCodeText.text == retrievedPassCode) {
            passCodeText.text  = ""
            AlarmView.isHidden = false
        } else {
            let alert = UIAlertController(title: "Incorrect Password.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            passCodeText.text = ""
        }
    }
    
    func createPassCode() {
        if(passCodeText.text?.count == 4) {
            firstInput = passCodeText.text
            enter.tag = 11
            passCodeText.text = ""
            passCodeLabel.text = "Please re-enter your passcode."
        } else {
            let alert = UIAlertController(title: "Passcode Must Be 4 Digits.", message: "Please re-enter passcode.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            passCodeLabel.text = "Please create a 4-digit passcode."
            passCodeText.text = ""
        }
    }
    
    func confirmPassCode() {
        secondInput = passCodeText.text
        passCodeText.text = ""
        
        if (secondInput == firstInput) {
            let passcode = secondInput!
            let saveSuccessful: Bool = KeychainWrapper.standard.set(passcode, forKey: "userPasscode")
            print("Save was successful: \(saveSuccessful)")
            self.view.endEditing(true)
            passCodeLabel.text = "Password saved."
        } else {
            let alert = UIAlertController(title: "Passcodes Do Not Match.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            firstInput = ""
            secondInput = ""
            enter.tag = 12
            passCodeLabel.text = "Please create a 4-digit passcode."
        }
    }
    
}

