//
//  SecondViewController.swift
//  Book Inventory
//
//  Created by Ananta Sjartuni on 22/3/18.
//  Copyright © 2018 Sjartuni. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtAuthor: UITextField!
    @IBOutlet weak var txtPublisher: UITextField!
    @IBOutlet weak var txtPublishDate: UITextField!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lbAddBook: UILabel!
    
    var dbHandling:PersistHandling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        modifyLabel(self.lbAddBook)
        modifyTextField(self.txtTitle)
        modifyTextField(self.txtAuthor)
        modifyTextField(self.txtPublisher)
        modifyTextField(self.txtPublishDate)
        self.txtPublishDate.placeholder = "DD-MMM-YYYY"
        
        dbHandling = PersistHandling()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func butAddClick(_ sender: Any) {
        let retval = validateText()
        
        if !retval.isValid {
            displayError(retval.msg!)
            return
        }
        
        let _ = dbHandling?.AddRecord(self.txtTitle.text, publisher: self.txtPublisher.text, author: self.txtAuthor.text, publish_date: self.txtPublishDate.text)
        
        resetInput()
        
        
    }
    
    private func modifyTextField(_ textField:UITextField) {
        textField.borderStyle = .none
        textField.layer.backgroundColor = UIColor.white.cgColor
        
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 0.0
    }
    private func modifyLabel(_ lbl:UILabel) {
        //lbl.borderStyle = .none
        lbl.layer.backgroundColor = UIColor.white.cgColor
        
        lbl.layer.masksToBounds = false
        lbl.layer.shadowColor = UIColor.gray.cgColor
        lbl.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        lbl.layer.shadowOpacity = 1.0
        lbl.layer.shadowRadius = 0.0
    }
}

// MARK:- Block for validation
extension SecondViewController {
    fileprivate func validateText() -> (isValid:Bool, msg:String?) {
        
        let txtTitel = self.txtTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if txtTitel == "" {
            return (false, "Book Title is required.")
        }
        
        if txtPublishDate.text!.count > 0 {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd-MMM-yyyy"
            let someDate = txtPublishDate.text
            
            if dateFormatterGet.date(from: someDate!) == nil {
                return (false, "Wrong date format.")
            }
        }
        
        return (true, "")
    }
    
    fileprivate func resetInput() {
        self.txtAuthor.text = ""
        self.txtPublisher.text = ""
        self.txtTitle.text = ""
        self.txtPublishDate.text = ""
    }
    
    fileprivate func displayError(_ err:String) {
        let con = UIAlertController(title: "Warning", message: err, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        con.addAction(ok)
        self.present(con, animated: true, completion: nil)
    }
}

