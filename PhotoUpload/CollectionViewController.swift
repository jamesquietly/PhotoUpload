//
//  CollectionViewController.swift
//  PhotoUpload
//
//  Created by James Ly on 12/19/17.
//  Copyright © 2017 James Ly. All rights reserved.
//

import UIKit
import Firebase

class CollectionViewController: UICollectionViewController {
    let databaseRef = Database.database().reference(withPath: "Posts")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    func photoRetrieveCallback() {
        databaseRef.queryOrdered(byChild: "Posts").observe(.value, with: {
            snapshot in
            var newPosts = [Post]()
            for item in snapshot.children {
                newPosts.append(Post(snapshot: item as! DataSnapshot))
            }
            print(newPosts)
        })
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
