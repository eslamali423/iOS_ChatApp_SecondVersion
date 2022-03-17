//
//  Helper.swift
//  myChatApp
//
//  Created by Eslam Ali  on 08/03/2022.
//

import Foundation
import Firebase

 let usersRef = "Users"



func firestoreReferance(_ ref : String) -> CollectionReference {
    return Firestore.firestore().collection(ref)
}



