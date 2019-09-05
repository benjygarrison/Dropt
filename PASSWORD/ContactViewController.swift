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
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        print(contact.phoneNumbers)
        let numbers = contact.phoneNumbers.first
        print((numbers?.value)?.stringValue ?? "")
        
        contactLabel.text = " \((numbers?.value)?.stringValue ?? "")"
        
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: true, completion: nil)
    }

}
