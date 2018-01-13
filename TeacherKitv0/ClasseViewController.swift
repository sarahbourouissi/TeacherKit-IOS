//
//  ClasseViewController.swift
//  teacherkit
//
//  Created by Admin on 2/2/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import Alamofire

class ClasseViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

     var tab : [Classe] = [Classe] ()
    var classes :   [String] =  ["4 sim2","3a4","4could1"]
        var classes2 :   [String] =  ["zzzzz","3ddddddd","ssssssld1","ssssssld1","ssssssld1"]
     var classes3 :   [String] =  ["AB","CH","SA","KJ","AY"]
    var f: String!
    var l: String!
    
    
    
    
    
    //IColor(hexString: <#T##String#> )
    var colors :  [UIColor] = [UIColor(name: "violet")!,UIColor(name: "violet")!,UIColor(name: "yellowgreen")!,UIColor(name: "red")!,UIColor(name: "purple")!]

 
    @IBOutlet weak var tableViewClasse: UITableView!
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()

  // print(tab [1].matricule)
   tableViewClasse.dataSource = self
   tableViewClasse.delegate = self
        // Do any additional setup after loading the view.
         getAllClasses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
             return tab.count
       
       
    }
    override func viewWillAppear(_ animated: Bool) {
       
        //snipper.stopAnimating()

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableViewClasse.dequeueReusableCell(withIdentifier: "myCell")!
        let Label1 : UILabel =  cell.viewWithTag(101) as! UILabel
        let Label2 : UILabel =  cell.viewWithTag(102) as! UILabel
        let image : UIImageView = cell.viewWithTag(103) as! UIImageView
        
        
      
        
        print(tab [indexPath.row].matricule)

           Label1.text = tab [indexPath.row].matricule
            Label2.text = tab [indexPath.row].matricule
         //   image.backgroundColor = tab [indexPath.row].couleur
        image.backgroundColor = hexStringToUIColor(hex: tab [indexPath.row].couleur)
        

        

        
        
        return cell
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
            return "Classes"
       
    }
    
    func getAllClasses()   {
        // Do any additional setup after loading the view, typically from a nib.
        
        
        Alamofire.request("http://sarah.alwaysdata.net/json_get_class.php?id_user=17", method: .get ).responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value{
                      print(json)
                   let jsonResult:NSArray = json  as! NSArray
                 //  let data : NSArray = (jsonResult as! NSArray).mutableCopy() as! NSMutableAr
                  

                   for l in jsonResult {
                    
                    
                    
                      let ev  : Classe = Classe(dic: l as! [String:Any])
                        
                        
                        
                        
                       self.tab.append(ev)
                    }
                    
                    
                    print("In Function getAll Classes "+String(self.tab.count))
                    self.tableViewClasse.reloadData()
                }
                
            case .failure(let error):
                print(error)
                        
            }
       

        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "DetailEtudiantSegue", sender: tab[indexPath.row])
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailEtudiantSegue" {
            let svc : MainTableViewController = segue.destination as! MainTableViewController
            svc.classe = sender as! Classe
            
        }
    }

    
    
}
