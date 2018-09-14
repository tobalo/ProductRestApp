//
//  MasterViewController.swift
//  CristobalTorres-CooperCarlson-Assignment5
//
//  Created by Somnio on 11/28/17.
//  Copyright © 2017 CristobalTorresValderas. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController


{

    var detailViewController: DetailViewController? = nil
    var ProductList = [[String:AnyObject]]()
    var ProductObj = [Products]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        self.retrieveFromURL()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    // WEB API
    
    func retrieveFromURL(){
        let myURL:String = "http://cis4320webapi.azurewebsites.net/api/products"
        guard let url = URL(string: myURL) else{
            print("error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest){
            (data, response, error) in
            // check for errors
            guard error == nil else{
                print("error calling GETon /todos/1")
                //print(error!.debugDescription)
                return
            }
            //make sure we got data
            guard let responseData = data else{
                print("error did not receive data")
                return
            }
            // parse the result as JSON since thats what API provides
            do{
               self.ProductList = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! [[String:AnyObject]]
                for i in 0..<self.ProductList.count {
                    var aProduct = self.ProductList[i]
                    let pID = aProduct["Id"] as! Int
                    let pName = aProduct["Name"] as! String
                    let pLP = aProduct["ListPrice"] as! Int
                    let pDisc = aProduct["Discount"] as! Int
                    
                    let bProduct = Products(i: pID, n: pName, lp: pLP, disc: pDisc)
                    self.ProductObj.append(bProduct)
                
                }
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }

    
    
    
    
    
    
    
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = ProductObj[indexPath.row]
                let objimage = UIImage(named: "\(object.id)")
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detID = object.id
                controller.detName = object.name
                controller.detPrice = object.listPrice
                controller.detDisc = object.discount
                controller.image = objimage
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    
    
    
    
    
    
    
    
    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ProductObj.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = ProductObj[indexPath.row]
        object.computeSalePrice()
        cell.textLabel!.text = object.name + " $" + "\(object.salePrice)"
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ProductObj.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

