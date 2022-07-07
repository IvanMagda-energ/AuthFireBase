//
//  ViewController.swift
//  AuthFireBase
//
//  Created by Иван Магда on 07.07.2022.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func logOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: {})
            self.navigationController?.popViewController(animated: true)
        } catch {
            print (error)
            return
        }
        
        
    }
    
    
}

