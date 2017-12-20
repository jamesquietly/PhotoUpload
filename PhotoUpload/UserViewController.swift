//
//  UserViewController.swift
//  PhotoUpload
//
//  Created by James Ly on 12/19/17.
//  Copyright © 2017 James Ly. All rights reserved.
//

import UIKit
import Firebase

class UserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let databaseRef = Database.database().reference(withPath: "Posts")
    let user = Auth.auth().currentUser
    let userLabel = UILabel()
    let panelLabel = UILabel()
    let viewButton = UIButton()
    let uploadButton = UIButton()
    let signOutButton = UIButton()
    
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        self.view.backgroundColor = .white
        
        //user label setup
        userLabel.text = "\(user!.email!)'s"
        userLabel.textColor = .black
        userLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(userLabel)
        
        //panel label setup
        panelLabel.text = "User Panel"
        panelLabel.textColor = .black
        panelLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        panelLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(panelLabel)
        
        //view photos button setup
        viewButton.setTitle("View Photos", for: .normal)
        viewButton.setTitleColor(.white, for: .normal)
        viewButton.backgroundColor = .blue
        viewButton.layer.borderColor = UIColor.black.cgColor
        viewButton.layer.borderWidth = 2
        viewButton.layer.cornerRadius = 3
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        //viewButton.addTarget(self, action: #selector(viewButtonAction), for: .touchUpInside)
        self.view.addSubview(viewButton)
        
        //upload button setup
        uploadButton.setTitle("Upload Photo", for: .normal)
        uploadButton.setTitleColor(.white, for: .normal)
        uploadButton.backgroundColor = .blue
        uploadButton.layer.borderColor = UIColor.black.cgColor
        uploadButton.layer.borderWidth = 2
        uploadButton.layer.cornerRadius = 3
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.addTarget(self, action: #selector(uploadButtonAction), for: .touchUpInside)
        self.view.addSubview(uploadButton)
        
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
        let views = ["userLabel": userLabel, "panelLabel": panelLabel, "uploadButton": uploadButton,
                     "viewButton": viewButton, "signOutButton":signOutButton]
        let metrics = ["width150": 150, "high50": 50, "width250": 250]
        
        //horizontal constraints
        constraints.append(NSLayoutConstraint(item: viewButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: uploadButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: signOutButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        
        //width of UI elements
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[userLabel]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[panelLabel]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[viewButton(width150)]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[uploadButton(width150)]", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "[signOutButton(width150)]", options: [], metrics: metrics, views: views)
        
        //height and vertical constraints
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[userLabel(high50)]-[panelLabel(high50)]-[viewButton(high50)]-[uploadButton(high50)]-[signOutButton(high50)]", options: [], metrics: metrics, views: views)
        
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
    
    @IBAction func uploadButtonAction(sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func viewButtonAction(sender: UIButton) {
        let collectionVC = CollectionViewController()
        present(collectionVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info["UIImagePickerControllerOriginalImage"] {
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("\(imageName).jpg")
            if let uploadData = UIImageJPEGRepresentation(selectedImage as! UIImage, 0.8) {
                storageRef.putData(uploadData, metadata: nil, completion:
                    { (metadata, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        
                        if let selectedImageUrl = metadata?.downloadURL()?.absoluteString {
                            self.postToDatabaseWithImageName(imageName: imageName, imageUrl: selectedImageUrl)
                        }
                })
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func postToDatabaseWithImageName(imageName: String, imageUrl: String) {
        let newPost = Post(uid: (user?.uid)!, imageUrl: imageUrl)
        let newRef = databaseRef.child(imageName)
        newRef.setValue(newPost.toAnyObject())
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
