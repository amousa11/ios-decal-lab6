//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    
    let label = UILabel()
    let loginView = UIView()
    let username = UITextField()
    let password = UITextField()
    let login = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        label.text = "Log in to this page"
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        view.addSubview(label)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        login.translatesAutoresizingMaskIntoConstraints = false
        
        loginView.backgroundColor = UIColor.white
        //login.backgroundColor = Constants.backgroundColor
        login.setTitleColor(UIColor.black, for: UIControlState())
        login.setTitle("Login", for: UIControlState())
        username.backgroundColor = UIColor.lightGray
        password.backgroundColor = UIColor.lightGray
        username.text = "Email"
        password.text = "Password"
    
        login.addTarget(self, action: #selector(loginButton), for: .touchUpInside)
    
        view.addSubview(loginView)
        loginView.addSubview(username)
        loginView.addSubview(password)
        loginView.addSubview(login)
        // TODO: layout your views using frames or AutoLayout
        let constraints = [
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        loginView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3, constant: 0),
        loginView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9, constant: 0),
        
        username.centerXAnchor.constraint(equalTo: loginView.centerXAnchor, constant: 0),
        password.centerXAnchor.constraint(equalTo: loginView.centerXAnchor, constant: 0),
        username.widthAnchor.constraint(equalTo: loginView.widthAnchor, multiplier: 0.75),
        password.widthAnchor.constraint(equalTo: loginView.widthAnchor, multiplier: 0.75),
        username.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 20),
        password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: username.bounds.height+20),
        login.centerXAnchor.constraint(equalTo: loginView.centerXAnchor, constant: 0),
        login.topAnchor.constraint(equalTo: password.bottomAnchor, constant: password.bounds.height+20)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // TODO: create an IBAction for your login button
    
    @IBAction func loginButton(sender: UIButton) {
        authenticateUser(username: username.text, password: password.text)
    }
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
