//
//  ContactViewController.swift
//  PASSWORD
//
//  Created by Benjamin Garrison on 9/5/19.
//  Copyright © 2019 Benji Garrison. All rights reserved.
//

import UIKit
import ContactsUI

class ContactViewController: UIViewController,CNContactPickerDelegate {

    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var contactLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func contactButtonClicked(_ sender: Any) {
        let contacVC = CNContactPickerViewController()
        contacVC.delegate = self
        self.present(contacVC, animated: true, completion: nil)
    }
    
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        
        let store = CNContactStore()
        
        switch CNContactStore.authorizationStatus(for: .contacts){
        case .authorized:
        print("authorized")
        case .notDetermined:
            store.requestAccess(for: .contacts){succeeded, err in
                guard err == nil && succeeded else{
                    return
                }
            }
        case .denied:
        print("denied")
        case .restricted:
        print("restricted")
        default:
            print("Not handled")
        }
    
        var numberArray: [String] = []
        
        for contact in contacts {

            let number = contact.phoneNumbers.first
            let firstName = contact.givenName
            let lastName = contact.familyName

            //contactLabel.text = " \((number?.value)?.stringValue ?? "")"
            numberArray.append((number?.value)?.stringValue ?? "")
            //print(numberArray)
            print(firstName +  " " + lastName + " \((number?.value)?.stringValue ?? "")")
        }

    }
    
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: true, completion: nil)
    }

}
