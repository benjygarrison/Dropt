//
//  EnterButtonFunctions.swift
//  PASSWORD
//
//  Created by Benjamin Garrison on 9/2/19.
//  Copyright © 2019 Benji Garrison. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper


class EnterButtonFunctions: UIView {
    
    func CreatePassword() {
    if (currentPassCode == nil && enter.tag == 12) {
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
    } else if (currentPassCode == nil && enter.tag == 11)  {
    //passCodeLabel.text = "Please re-enter your passcode."
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
}
