//
//  FirebaseManager.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 26/08/25.
//

import Foundation
import Firebase
import FirebaseStorage

final class FirebaseManager {
    static let shared = FirebaseManager()
    let firestore = Firestore.firestore()
    let firebaseStorage = Storage.storage()
    
    init() {}
}
