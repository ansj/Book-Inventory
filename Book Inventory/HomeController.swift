//
//  FirstViewController.swift
//  Book Inventory
//
//  Created by Ananta Sjartuni on 22/3/18.
//  Copyright © 2018 Sjartuni. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var lblPSI: UILabel!
    @IBOutlet weak var lblPM25: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    
    @IBOutlet weak var lbPM25:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.preparePMLabel()
        
        
        let api = ApiHandling()
        api.getAPI(apiURLType.PSI_URL, with:
            { (result:String?, err:Error?) in
                
                DispatchQueue.main.async {
                    self.lblPSI.text = result!
                }
                //print(result)
            })
        
        api.getAPI(apiURLType.PM_URL) { (result:String?, err:Error?) in
            DispatchQueue.main.async {
                self.lblPM25.text = result!
            }

        }

        api.getAPI(apiURLType.WEATHER_URL) { (result:String?, err:Error?) in
            DispatchQueue.main.async {
                self.lblWeather.text = result!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: this for text formatting
extension HomeController {
    
    private func preparePMLabel () {
        let font:UIFont? = UIFont.boldSystemFont(ofSize: 17.0)//UIFont(name: "Helvetica", size:17)
        let fontSubs:UIFont? = UIFont.boldSystemFont(ofSize: 13.0)//UIFont(name: "Helvetica", size:13)
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: "PM2.5:", attributes: [.font:font!])
        attString.setAttributes([.font:fontSubs!,.baselineOffset:-3], range: NSRange(location:2,length:3))
        self.lbPM25.attributedText = attString
    }
    
}

