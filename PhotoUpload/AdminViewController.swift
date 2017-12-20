//
//  AdminViewController.swift
//  PhotoUpload
//
//  Created by James Ly on 12/19/17.
//  Copyright © 2017 James Ly. All rights reserved.
//

import UIKit
import FirebaseAuth

class AdminViewController: UIViewController {
    let user = Auth.auth().currentUser
    let userLabel = UILabel()
    let panelLabel = UILabel()
    let signOutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        
        //user label setup
        userLabel.text = "\(user!.email!)'s"
        userLabel.textColor = .black
        userLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(userLabel)
        
        //panel label setup
        panelLabel.text = "Admin Panel"
        panelLabel.textColor = .black
        panelLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        panelLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(panelLabel)
        
        //sign out button setup
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.backgroundColor = .red
        signOutButton.layer.borderColor = UIColor.black.cgColor
        signOutButton.layer.borderWidth = 2
        signOutButton.layer.cornerRadius = 3
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.addTarget(self, action: #selector(self.signOutButtonAction), for: .touchUpInside)
        self.view.addSubview(signOutButton)
        
        //constraints
        var constraints = [NSLayoutConstraint]()
        let views = ["userLabel": userLabel, "panelLabel": panelLabel,
                     "signOutButton":signOutButton]
        let metrics = ["width150": 150, "high50": 50, "width250": 250]
        
        //horizontal constraints
        constraints.append(NSLayoutConstraint(item: signOutButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        
        //width of UI elements
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[userLabel]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[panelLabel]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[signOutButton(width150)]", options: [], metrics: metrics, views: views)
        
        //height and vertical constraints
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[userLabel(high50)]-[panelLabel(high50)]-[signOutButton(high50)]", options: [], metrics: metrics, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @IBAction func signOutButtonAction(sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("error signing out: %@", signOutError)
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
