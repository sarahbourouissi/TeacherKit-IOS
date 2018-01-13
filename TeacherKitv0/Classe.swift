//
//  Classe.swift
//  teacherkit
//
//  Created by Admin on 2/3/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class Classe: NSObject {
    
    var id: Int!
    var matricule: String!
    var matiere: String!
    var datedebut: String!
    var datefin: String!
    var descrip: String!
    var couleur: String!
    var id_user: Int!
    
    override init() {
        
        
    }
    init(dic : [String:Any]) {
        /* Start these objects will recover by AllEvents API */
        
        id  = Int(dic["id"] as! String)
        matricule = dic["matricule"] as? String!
        matiere = dic["matiere"] as? String!
        datedebut = dic["datedebut"] as? String!
        datefin = dic["datefin"]as! String
        descrip = dic["description"]as! String
       couleur = dic["couleur"]as! String
        id_user  = Int(dic["id_user"] as! String)
      
    }

    
    

}
