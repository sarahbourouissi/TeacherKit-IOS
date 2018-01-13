//
//  DetailEtudiantpagerViewController.swift
//  TeacherKitv0
//
//  Created by KhoukhaZz on 08/03/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class DetailEtudiantpagerViewController: UIViewController {
    var etudiant : Etudiant? = nil

    @IBOutlet weak var LbTelephone: UILabel!
    @IBOutlet weak var LbMail: UILabel!
    @IBOutlet weak var LbPrenom: UILabel!
    @IBOutlet weak var LbNom: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(etudiant?.nom)
        
        LbNom.text = DetailEtudiantViewController.etudiantS?.nom
        LbMail.text = DetailEtudiantViewController.etudiantS?.mail
        LbPrenom.text = DetailEtudiantViewController.etudiantS?.prenom
        LbTelephone.text = "\(DetailEtudiantViewController.etudiantS?.num_tel)"

        // Do any additional setup after loading the view.
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
