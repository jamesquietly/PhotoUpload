//
//  ViewController.swift
//  PhotoUpload
//
//  Created by James Ly on 12/18/17.
//  Copyright © 2017 James Ly. All rights reserved.
//

import UIKit
import FirebaseAuth

//Main login view controller
class ViewController: UIViewController {
    let emailLabel = UILabel()
    let passwordLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        //email label setup
        emailLabel.text = "Email"
        emailLabel.textColor = .black
        emailLabel.textAlignment = .center
        emailLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(emailLabel)
        
        //password label setup
        passwordLabel.text = "Password"
        passwordLabel.textColor = .black
        passwordLabel.textAlignment = .center
        passwordLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordLabel)
        
        //email text field
        emailTextField.placeholder = "Enter email"
        emailTextField.isSecureTextEntry = false
        emailTextField.textColor = .black
        emailTextField.borderStyle = .line
        emailTextField.autocorrectionType = .no
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.autocapitalizationType = .none
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(emailTextField)
        
        //password text field
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .black
        passwordTextField.borderStyle = .line
        passwordTextField.autocorrectionType = .no
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordTextField)
        
        //login button setup
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 2
        loginButton.layer.cornerRadius = 3
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        self.view.addSubview(loginButton)
        
        //sign up button setup
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.cornerRadius = 3
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(self.signUpButtonAction), for: .touchUpInside)
        self.view.addSubview(signUpButton)
        
        //constraints
        var constraints = [NSLayoutConstraint]()
        let views = ["emailLabel": emailLabel, "emailTextField": emailTextField,
                     "passwordLabel": passwordLabel, "passwordTextField": passwordTextField,
                     "loginButton": loginButton, "signUpButton": signUpButton]
        let metrics = ["width150": 150, "high50": 50, "width250": 250]
        
        //horizontal constraints
        constraints.append(NSLayoutConstraint(item: emailLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: emailTextField, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: passwordLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: passwordTextField, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: signUpButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        
        //width of UI elements
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-[emailLabel]-|", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[emailTextField(width250)]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-[passwordLabel]-|", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[passwordTextField(width250)]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[loginButton(width150)]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[signUpButton(width150)]", options: [], metrics: metrics, views: views)
        
        //height and vertical constraints
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[emailLabel(high50)]-[emailTextField(high50)]-[passwordLabel(high50)]-[passwordTextField(high50)]-[loginButton]-[signUpButton]", options: [], metrics: metrics, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    //sign up in another view
    @IBAction func signUpButtonAction(sender: UIButton) {
        let signUpVC = SignUpViewController()
        self.present(signUpVC, animated: true, completion: nil)
    }
    
    //login in with firebase auth
    @IBAction func loginButtonAction(sender: UIButton) {
        let alertController = UIAlertController(title: "Message", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        if (emailTextField.text! == "") {
            alertController.message = "Email field is empty"
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        if (passwordTextField.text! == "") {
            alertController.message = "Password field is empty"
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        if (emailTextField.text! != "" && passwordTextField.text! != "") {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                //no error
                if(error == nil) {
                    //if user is admin, go to admin panel
                    if(user!.email! == "admin@photoupload.com") {
                        let adminVC = AdminViewController()
                        self.present(adminVC, animated: true, completion: nil)
                    }
                    //go to regular user panel
                    else {
                        let userVC = UserViewController()
                        self.present(userVC, animated: true, completion: nil)
                    }
                }
                else {
                    alertController.message = "\(error!)"
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

