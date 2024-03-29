//
//  ViewController.swift
//  PASSWORD
//
//  Created by Benjamin Garrison on 8/31/19.
//  Copyright © 2019 Benji Garrison. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import CoreData
import MessageUI

class PassCodeViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    
    //Variables
    
    @IBOutlet var StandardView: UIView!
    @IBOutlet weak var AlarmView: UIView!
    @IBOutlet weak var passCodeText: UITextField!
    var passCodeDefault: String = ""
    @IBOutlet weak var passCodeLabel: UILabel!
    @IBOutlet weak var enter: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var countDownLabel: UILabel!
    
    
    let currentPassCode: String? = KeychainWrapper.standard.string(forKey: "userPasscode")
    var firstInput: String?
    var secondInput: String?
    
    var longGesture = UILongPressGestureRecognizer()
    
    var countdown = 8
    var timer = Timer()
    
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
        
        longGesture = UILongPressGestureRecognizer(target: self, action: #selector(PassCodeViewController.longPress(_:)))
        longGesture.minimumPressDuration = 0.1
        AlarmView.addGestureRecognizer(longGesture)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: true)
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
    
    
    
    
    
    //Temp Actions
    
    @IBAction func checkPassCode(_ sender: UIButton) {
        let retrievedPassCode: String? = KeychainWrapper.standard.string(forKey: "userPasscode")
        print("Retrieved pass code is: \(retrievedPassCode!)")
    }
    
    @IBAction func deletePassCode(_ sender: UIButton) {
        let _: Bool = KeychainWrapper.standard.removeObject(forKey: "userPasscode")
        print("Pass code deleted.")
    }
    
    
    
    
    //Functions (TODO: move to Model files?)
    
    func sendMessage(_ sender: Any) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "Alarm message would have gone here";
        messageVC.recipients = ["contact numbers would have gone here"]
        messageVC.messageComposeDelegate = self
        
        self.present(messageVC, animated: true, completion: nil)
    }

    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            dismiss(animated: true, completion: nil)
        default:
            break
        }

    }
    
    
    func passCodeExists() {
        let retrievedPassCode: String? = KeychainWrapper.standard.string(forKey: "userPasscode")
        if (passCodeText.text == retrievedPassCode) {
            passCodeText.text  = ""
            if(StandardView.backgroundColor == .red){
                checkButton.sendActions(for: .touchUpInside)
            } else {
                AlarmView.isHidden = false
            }
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
            let alert = UIAlertController(title: "Passcode Created.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                self.checkButton.sendActions(for: .touchUpInside)}))
            self.present(alert, animated: true, completion: nil)
            
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
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizer.State.began {
            print("holding")
        }
        if sender.state == UIGestureRecognizer.State.ended {
            AlarmView.isHidden = true
            StandardView.backgroundColor = .red
            passCodeLabel.backgroundColor = .red
            passCodeText.backgroundColor = .red
            //update()
        }
    }
    
    @objc func update() {
        if (StandardView.backgroundColor == .red){
        countdown = countdown - 1
        countDownLabel.text = String(countdown)
            if (countdown == 0){
                countDownLabel.text = "ALARM"
                timer.invalidate()
                sendMessage((Any).self)
            }
        }
    }
}

