//
//  BookListCont.swift
//  Book Inventory
//
//  Created by Ananta Sjartuni on 25/3/18.
//  Copyright © 2018 Disrptiv. All rights reserved.
//

import UIKit

class cellBookList: UITableViewCell {
    @IBOutlet weak var lbTitle:UILabel!
    @IBOutlet weak var lbAuthor:UILabel!
    @IBOutlet weak var lbPublisher:UILabel!
    @IBOutlet weak var lbPublishDate:UILabel!
}

class BookListCont: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblView:UITableView!
    
    fileprivate var books:[(title:String?, publisher:String?, author:String?, publish_date:String?)]?
    fileprivate var dataHandling:PersistHandling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataHandling = PersistHandling()
        books = dataHandling?.getRecords()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        books = dataHandling?.getRecords()
        self.tblView.reloadData()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (books?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellBookListID", for: indexPath) as! cellBookList
        
        cell.lbTitle.text = books![indexPath.row].title
        cell.lbAuthor.text = books![indexPath.row].author
        cell.lbPublisher.text = books![indexPath.row].publisher
        cell.lbPublishDate.text = books![indexPath.row].publish_date
        return cell
    }

}


