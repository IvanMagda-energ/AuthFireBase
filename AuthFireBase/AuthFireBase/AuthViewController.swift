//
//  AuthViewController.swift
//  AuthFireBase
//
//  Created by Иван Магда on 07.07.2022.
//

import Foundation
import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    var signUp: Bool = true {
        willSet {
            if newValue {
                label.text = "Registration"
                nameTextField.isHidden = false
                login.setTitle("SignIn", for: .normal)
            } else {
                label.text = "Signin"
                nameTextField.isHidden = true
                login.setTitle("Registration", for: .normal)
            }
        }
    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        self.signUp = !signUp
    }
    
    func showWelcomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(identifier: "WelcomeViewController") as! WelcomeViewController
        self.view.window?.rootViewController?.present(newVC, animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        if (signUp) {
            if (!name.isEmpty && !email.isEmpty && !password.isEmpty) {
                Auth.auth().createUser(withEmail: email, password: password) {result, error in
                    if error == nil {
                        self.showWelcomeViewController()
                    }
                }
            } else {
                showAlert(message: "You have empty fields")
            }
        } else {
            if (!email.isEmpty && !password.isEmpty) {
                Auth.auth().signIn(withEmail: email, password: password) {result, error in
                    if error == nil {
                        self.showWelcomeViewController()
                    } else {
                        self.showAlert(message: "Incorrect email or password")
                    }
                }
            } else {
                showAlert(message: "You have empty fields")
            }
        }
        return true
    }
}
