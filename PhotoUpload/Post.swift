//
//  Post.swift
//  PhotoUpload
//
//  Created by James Ly on 12/19/17.
//  Copyright © 2017 James Ly. All rights reserved.
//

import Foundation
import Firebase

class Post: NSObject {
    var uid : String
    var imageUrl: String
    let ref: DatabaseReference?
    
    init(uid: String, imageUrl: String) {
        self.uid = uid
        self.imageUrl = imageUrl
        ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapValues = snapshot.value as! [String: AnyObject]
        uid = snapValues["uid"] as! String
        imageUrl = snapValues["imageUrl"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return ["uid": uid, "imageUrl": imageUrl]
    }
}
