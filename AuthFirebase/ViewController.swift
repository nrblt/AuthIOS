//
//  ViewController.swift
//  AuthFirebase
//
//  Created by MacBook on 20.04.2022.
//

import UIKit
import FirebaseAuth
import Firebase


class ViewController: UIViewController {


    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        passwordTF.isSecureTextEntry = true
        view.backgroundColor = .systemPurple
        passwordTF.placeholder = "Password"
        loginTF.placeholder = "Email"

    }

    @IBAction func goToReg(_ sender: Any) {
        print("REg is tapped")
        let regVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterID") as! RegisterController
//        let regVC=RegisterController()
//        self.navigationController?.pushViewController(RegVC, animated: true)
//        presentViewController
        self.navigationController?.pushViewController(regVC, animated: true)
        
    }
    @IBAction func logInButton(_ sender: Any) {
        print("Login button tapped")
        guard let email = loginTF.text, !email.isEmpty,
              let password = passwordTF.text, !password.isEmpty else{
            print("Missing field data")
            return
        }
//        AuthFirebase.Auth.auth().signIn(
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self]result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else{
                //show account creation
                strongSelf.showCreatedAccount(email: email,password: password)
                return
            }
            print("You have signed in")
            
        })
        let regVC = self.storyboard?.instantiateViewController(withIdentifier: "LogId") as! LoggedInController
//        let regVC=RegisterController()
//        self.navigationController?.pushViewController(RegVC, animated: true)
//        presentViewController
        self.navigationController?.pushViewController(regVC, animated: true)
        
        
    }
    func showCreatedAccount(email: String, password: String){
        let alert = UIAlertController(title: "Error", message: "There is no account like this", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,  handler: {_ in }))
        present(alert, animated: true)
    }
    
}

