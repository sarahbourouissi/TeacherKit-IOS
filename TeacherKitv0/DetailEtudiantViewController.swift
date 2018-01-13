//
//  ViewController.swift
//  Demo
//
//  Created by xxxAIRINxxx on 2016/01/05.
//  Copyright © 2016 xxxAIRINxxx. All rights reserved.
//

import UIKit
import ViewPagerController

class DetailEtudiantViewController: UIViewController {
    
    @IBOutlet weak var layerView : UIView!
      var etudiant : Etudiant? = nil
    static var etudiantS : Etudiant? = nil

    var pagerController : ViewPagerController?

    override func viewDidLoad() {
        super.viewDidLoad()
        DetailEtudiantViewController.etudiantS = etudiant
        let pagerController = ViewPagerController()
        pagerController.setParentController(self, parentView: self.layerView)
        
        var appearance = ViewPagerControllerAppearance()
        
        appearance.headerHeight = 200.0
        appearance.scrollViewMinPositionY = 20.0
        appearance.scrollViewObservingType = .header
        
        /***/
      

        
        let thumbnailURL = URL(string:  (etudiant?.image)!)
        let imageView = UIImageView()
        
        /***/
        /***/
        
        let imageCache = NSCache<AnyObject, AnyObject>()
        /******** load the image ************/
        if(thumbnailURL != nil){
            
            
            if let imageFromCache = imageCache.object(forKey: etudiant?.id as AnyObject) as? UIImage {
                imageView.image = imageFromCache
                
            }
            else {
                // load the image from the internet
                
                
                let networkService = NetworkService(url: (thumbnailURL)!)
                networkService.downloadImage { (imageData) in
                    
                    
                    DispatchQueue.main.async(execute: {
                        let  imageToCache = UIImage(data: imageData as Data)
                        
                        imageCache.setObject(imageToCache!, forKey: self.etudiant?.id as AnyObject )
                        imageView.image = imageToCache
                    })
                }
                
            }
        }
        /******** load the image ************/
        
              imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        appearance.headerContentsView = imageView
        
        appearance.tabMenuAppearance.selectedViewBackgroundColor = UIColor.green
        appearance.tabMenuAppearance.selectedViewInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        
        pagerController.updateAppearance(appearance)
        
        pagerController.updateSelectedViewHandler = { selectedView in
            selectedView.layer.cornerRadius = selectedView.frame.size.height * 0.5
        }
               
        pagerController.willBeginTabMenuUserScrollingHandler = { selectedView in
            print("call willBeginTabMenuUserScrollingHandler")
            selectedView.alpha = 0.0
        }
        
        pagerController.didEndTabMenuUserScrollingHandler = { selectedView in
            print("call didEndTabMenuUserScrollingHandler")
            selectedView.alpha = 1.0
        }
        
        pagerController.didShowViewControllerHandler = { controller in
            print("call didShowViewControllerHandler")
            print("controller : \(controller.title)")
            let currentController = pagerController.currentContent()
            print("currentContent : \(currentController?.title)")
        }
        
     /*   pagerController.changeObserveScrollViewHandler = { controller in
            print("call didShowViewControllerObservingHandler")
            let detailController = controller as! DetailViewController
            
            return detailController.tableView
        } */
        
        pagerController.didChangeHeaderViewHeightHandler = { height in
            print("call didChangeHeaderViewHeightHandler : \(height)")
        }
        
        pagerController.didScrollContentHandler = { percentComplete in
            print("call didScrollContentHandler : \(percentComplete)")
        }
        
        for title in sampleDataTitles {
            if(title == "Detail Etudiant"){
                
                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailet") as! DetailEtudiantpagerViewController
                controller.view.clipsToBounds = true
                controller.title = title
           
                
                 pagerController.addContent(title, viewController: controller)
                //comportement
            
            } else if(title == "comportement"){
                
                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "comportement") as! ComportementViewController
                controller.view.clipsToBounds = true
                controller.title = title
                
                
                pagerController.addContent(title, viewController: controller)
                //comportement
                
            } else {
                
                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                controller.view.clipsToBounds = true
                controller.title = title
                controller.parentController = self
                pagerController.addContent(title, viewController: controller)
                
                
            }
            
            
        }
        
        self.pagerController = pagerController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

