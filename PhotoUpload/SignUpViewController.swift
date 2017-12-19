//
//  SignUpViewController.swift
//  PhotoUpload
//
//  Created by James Ly on 12/18/17.
//  Copyright © 2017 James Ly. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    let emailLabel = UILabel()
    let passwordLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let passwordTextField2 = UITextField()
    let signUpButton = UIButton()
    let cancelButton = UIButton()
    
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
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordTextField)
        
        passwordTextField2.placeholder = "Re-enter password"
        passwordTextField2.isSecureTextEntry = true
        passwordTextField2.textColor = .black
        passwordTextField2.borderStyle = .line
        passwordTextField2.autocorrectionType = .no
        passwordTextField2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordTextField2)
        
        //sign up button setup
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .blue
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.cornerRadius = 3
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(self.signUpButtonAction), for: .touchUpInside)
        self.view.addSubview(signUpButton)
        
        //cancel button setup
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.backgroundColor = .white
        cancelButton.layer.borderColor = UIColor.black.cgColor
        cancelButton.layer.borderWidth = 2
        cancelButton.layer.cornerRadius = 3
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(self.cancelButtonAction), for: .touchUpInside)
        self.view.addSubview(cancelButton)
        
        //constraints
        var constraints = [NSLayoutConstraint]()
        let views = ["emailLabel": emailLabel, "emailTextField": emailTextField,
                     "passwordLabel": passwordLabel, "passwordTextField": passwordTextField,
                     "passwordTextField2": passwordTextField2,
                     "signUpButton": signUpButton, "cancelButton": cancelButton]
        let metrics = ["width150": 150, "high50": 50, "width250": 250]
        
        //horizontal constraints
        constraints.append(NSLayoutConstraint(item: emailLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: emailTextField, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: passwordLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: passwordTextField, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: passwordTextField2, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: signUpButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: cancelButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        
        //width of UI elements
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-[emailLabel]-|", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[emailTextField(width250)]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-[passwordLabel]-|", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[passwordTextField(width250)]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[passwordTextField2(width250)]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[signUpButton(width150)]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[cancelButton(width150)]", options: [], metrics: metrics, views: views)
        
        //height of elements and vertical constraints
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[emailLabel(high50)]-[emailTextField(high50)]-[passwordLabel(high50)]-[passwordTextField(high50)]-[passwordTextField2(high50)]-[signUpButton]-[cancelButton]", options: [], metrics: metrics, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @IBAction func cancelButtonAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonAction(sender: UIButton) {
        let alertController = UIAlertController(title: "Message", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        //check if password is same
        if (passwordTextField.text! == passwordTextField2.text!) {
            //make sure email field is not empty
            if (emailTextField.text! == "") {
                alertController.message = "Email field is empty"
                alertController.addAction(okAction)
            }
            else {
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                        //if no error signing up
                        if (error == nil) {
                            let doneAction = UIAlertAction(title: "Done", style: .default) { (someAction: UIAlertAction) in
                                //present user view panel
                                let userVC = UserViewController()
                                self.present(userVC, animated: true, completion: nil)
                            }
                            alertController.message = "User successfully created"
                            alertController.addAction(doneAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                        // there is error so display message
                        else {
                            alertController.message = "\(error!)"
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
            }
        }
        else {
            alertController.message = "Passwords do not match"
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
