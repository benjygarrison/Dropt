//
//  HomeViewController.swift
//  PASSWORD
//
//  Created by Benjamin Garrison on 9/1/19.
//  Copyright © 2019 Benji Garrison. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class HomeViewController: UIViewController {

    
    
    @IBOutlet weak var activateButton: UIButton!
    
    
    let retrievedPassCode: String? = KeychainWrapper.standard.string(forKey: "userPasscode")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (retrievedPassCode != nil) {
            activateButton.setTitle("Activate", for: .normal)
        }
        else {
            activateButton.setTitle("Set Up", for: .normal)
            
        }
        
        
    }
    



}
