//
//  MainTableViewController.swift
//
// Copyright (c) 21/12/15. Ramotion Inc. (http://ramotion.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import Alamofire

class MainTableViewController: UITableViewController {
    
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
         var tab : [Etudiant] = [Etudiant] ()
    let kRowsCount = 10
    var classe: Classe? = nil
    var cellHeights = [CGFloat]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllStudents()
        
        createCellHeightsArray()
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    // MARK: configure
    func createCellHeightsArray() {
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tab.count    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      
      guard case let cell as DemoCell = cell else {
        return
      }
           cell.actionD.tag = indexPath.row
        cell.actionD.addTarget(self, action: #selector(self.EsemFonction(sender:)), for: .touchUpInside)
      
      cell.backgroundColor = UIColor.clear
        
      if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight {
        cell.selectedAnimation(false, animated: false, completion:nil)
      } else {
        cell.selectedAnimation(true, animated: false, completion: nil)
      }
      
      cell.number = indexPath.row
    }
   
   
    
    
    func EsemFonction(sender:UIButton){
        
        print("Selected item in row \(sender.tag)")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailEtudiantViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailEtudiantViewController") as! DetailEtudiantViewController
        
        detailEtudiantViewController.etudiant = tab[sender.tag]
        self.show(detailEtudiantViewController, sender: nil)
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath)
        
        let Label1 : UILabel =  cell.viewWithTag(110) as! UILabel
        let Label2 : UILabel =  cell.viewWithTag(111) as! UILabel
        
    
        
    let image1 : UIImageView = cell.viewWithTag(113) as! UIImageView
    let image2 : UIImageView = cell.viewWithTag(114) as! UIImageView
        
        Label1.text = tab [indexPath.row].nom
        Label2.text = tab [indexPath.row].prenom

        /***/
       
        let thumbnailURL = URL(string:  tab[indexPath.row].image)
        
        
        /***/
        /***/
        
        let imageCache = NSCache<AnyObject, AnyObject>()
        /******** load the image ************/
        if(thumbnailURL != nil){
            
            
            if let imageFromCache = imageCache.object(forKey: self.tab[indexPath.row].id as AnyObject) as? UIImage {
                image1.image = imageFromCache
                
            }
            else {
                // load the image from the internet
                
                
                let networkService = NetworkService(url: (thumbnailURL)!)
                networkService.downloadImage { (imageData) in
                    
                    
                    DispatchQueue.main.async(execute: {
                        let  imageToCache = UIImage(data: imageData as Data)
                        
                        imageCache.setObject(imageToCache!, forKey: self.tab[indexPath.row].id as AnyObject )
                        image1.image = imageToCache
                    })
                }
                
            }
        }
        /******** load the image ************/
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[(indexPath as NSIndexPath).row]
    }
    
    // MARK: Table vie delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight { // open cell
            cellHeights[(indexPath as NSIndexPath).row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[(indexPath as NSIndexPath).row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)

        
    }
    func getAllStudents()   {
        // Do any additional setup after loading the view, typically from a nib.
        
        
        Alamofire.request("http://sarah.alwaysdata.net/json_get_etudiant.php?id=59", method: .get ).responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful")
                if let json = response.result.value{
                    print(json)
                    let jsonResult:NSArray = json  as! NSArray
                    //  let data : NSArray = (jsonResult as! NSArray).mutableCopy() as! NSMutableAr
                    
                    
                    for l in jsonResult {
                       let ev  : Etudiant = Etudiant(dic: l as! [String:Any])
                       self.tab.append(ev)
                    }
                    print("In Function getAll Classes "+String(self.tab.count))
                self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
                
            }
            
            
        }
        
        
        
    }

    
}
