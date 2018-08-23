//
//  ViewController.swift
//  firebase.login
//
//  Created by 濱田裕史 on 2018/08/19.
//  Copyright © 2018年 濱田裕史. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle!
    @IBOutlet weak var registeringEmail: UITextField!
    @IBOutlet weak var registeringPassword: UITextField!
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registeringPassword.isSecureTextEntry = true
        loginPassword.isSecureTextEntry = true
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    @IBAction func register(_ sender: Any) {
        guard let email = registeringEmail.text, let password = registeringPassword.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if (user != nil && error == nil) {
                print("register successed")
                self.registeringEmail.text = "";
                self.registeringPassword.text = ""
            } else {
                print("register failed")
            }
        }
    
    }
    @IBAction func login(_ sender: Any) {
        
        guard let email = loginEmail.text, let password = loginPassword.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if (user != nil && error == nil) {
                let viewcontorller:LoginSuccessedViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginSuccessedViewController") as! LoginSuccessedViewController
                self.navigationController?.pushViewController(viewcontorller, animated: true)
            } else {
                print("user not found")
            }
        }
    }
}

