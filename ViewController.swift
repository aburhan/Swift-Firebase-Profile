//
//  ViewController.swift
//  sample_profile
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    //variables
    let databaseRef = FIRDatabase.database().reference(fromURL: "https://profiletuts.firebaseio.com")
    //outlets
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //actions
    @IBAction func loginButton(_ sender: Any) {
        login()
    }
    @IBAction func signUpButton(_ sender: Any) {
        signup()
    }
    
    //func
    func login(){
        print("login in")
        guard let email = email.text else{
            print("email issue")
            return
        }
        guard let password = password.text else{
            print("password issue")
            return
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password
        , completion: { (user, error) in
            if error != nil{
                print("not signed in")
                print(error!)
                return
            }
            print("signed in")
            self.dismiss(animated: true, completion: nil)
        })
    }
    func signup(){
        guard let username = username.text else{
            print("username issue")
            return
        }
        guard let email = email.text else{
            print("email issue")
            return
        }
        guard let password = password.text else{
            print("password issue")
            return
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil{
                print(error!)
                return
            }
            guard let uid = user?.uid else{
                return
            }
            
            let userReference = self.databaseRef.child("users").child(uid)
            let values = ["username": username, "email": email, "pic":""]
            
            userReference.updateChildValues(values
                , withCompletionBlock: { (error, ref) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    self.dismiss(animated: true, completion: nil)
            })
            
        })
        
    }
    

}

