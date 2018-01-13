//
//  Etudiant.swift
//  teacherkit
//
//  Created by Admin on 2/3/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class Etudiant: NSObject {
    
    
    var id: Int!
    var nom: String!
    var prenom: String!
    var mail: String!
    var image: String!
    var num_tel: Int!
    var id_classe: Int!
    

    init(dic : [String:Any]) {
        /* Start these objects will recover by AllEvents API */
        
        id  = Int(dic["id"] as! String)
        nom = dic["nom"] as? String!
        prenom = dic["prenom"] as? String!
        mail = dic["mail"] as? String!
        image = dic["image"]as! String
        num_tel = Int(dic["num_tel"] as! String)
       id_classe  = Int(dic["id_classe"] as! String)
        
    }

}
