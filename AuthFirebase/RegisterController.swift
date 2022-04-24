//
//  RegisterController.swift
//  AuthFirebase
//
//  Created by MacBook on 21.04.2022.
//

import UIKit
import FirebaseAuth
import Firebase


class RegisterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.placeholder="Email"
        password1.placeholder="Password"
        password2.placeholder="Check Password"
        password1.isSecureTextEntry = true
        password2.isSecureTextEntry = true
    }
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var password1: UITextField!
    
    @IBOutlet weak var password2: UITextField!
    @IBAction func registerButton(_ sender: Any) {
        
        if(password2.text==password1.text){
            guard let email = emailTF.text, !email.isEmpty,
                  let password = password1.text, !password.isEmpty else{
                print("Missing field data")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self] result, error in
                        guard let strongSelf = self else{
                            return
                        }
                        guard error == nil else{
                            print("Account creation failed ")
                            //show account creation
            //                strongSelf.showCreatedAccount(email: email,password: password)
                            return
                        }
                        print("You have created new user")
                    })
            let alert = UIAlertController(title: "Congratz", message: "You have registered!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default,  handler: {_ in }))
            present(alert, animated: true)

            
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Password and password confirmation are not equal", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default,  handler: {_ in }))
            present(alert, animated: true)


        }
        }
    }

