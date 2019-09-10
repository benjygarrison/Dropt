//
//  ContactViewController.swift
//  PASSWORD
//
//  Created by Benjamin Garrison on 9/5/19.
//  Copyright © 2019 Benji Garrison. All rights reserved.
//

import UIKit
import ContactsUI
import CoreData

class ContactViewController: UIViewController, CNContactPickerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var contactTableView: UITableView!
    
    
    var userContacts = [UserContact]()
    
    //var isChecked = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactTableView.delegate = self
        contactTableView.dataSource = self

        let fetchRequest: NSFetchRequest<UserContact> = UserContact.fetchRequest()
        
        do {
            let userContacts = try PersistenceService.context.fetch(fetchRequest)
            self.userContacts = userContacts
            self.contactTableView.reloadData()
        } catch {
            print("tried, but failed")
        }
        
    }
    
    
    

    
    
    @IBAction func addButtonClicked(_ sender: Any) {
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
    
        //var numberArray: [String] = []
        
        
        
        for contact in contacts {
            
            let userContact = UserContact(context: PersistenceService.context)
            let number = contact.phoneNumbers.first
            let firstName = contact.givenName
            let lastName = contact.familyName
            
            userContact.phoneNumber = (number?.value)?.stringValue ?? ""
            userContact.firstName = firstName
            userContact.lastName = lastName
            
            PersistenceService.saveContext()
            self.userContacts.append(userContact)
            self.contactTableView.reloadData()
            
            //numberArray.append((number?.value)?.stringValue ?? "")
            print(firstName +  " " + lastName + " \((number?.value)?.stringValue ?? "")")
        }
        
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //tableview functions
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = userContacts[indexPath.row].firstName
        cell.detailTextLabel?.text = userContacts[indexPath.row].phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let deletedUser = userContacts[indexPath.row]
            PersistenceService.context.delete(deletedUser)
            PersistenceService.saveContext()
            print("deleted")
            userContacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}

