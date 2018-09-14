//
//  DetailViewController.swift
//  CristobalTorres-CooperCarlson-Assignment5
//
//  Created by Somnio on 11/28/17.
//  Copyright © 2017 CristobalTorresValderas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var pID: UILabel!
    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var pPrice: UILabel!
    @IBOutlet weak var pDisc: UILabel!
    @IBOutlet weak var prodImg: UIImageView!
    
    var detName:String = ""
    var detID:Int = 0
    var detPrice:Int = 0
    var detDisc:Int = 0
    var image: UIImage!

    func configureView() {
        // Update the user interface for the detail item.
        self.title = "Product Details"
        
        pID.text = "Product ID: \(detID)"
        pName.text = "Product Name: " + detName
        pPrice.text = "Product Price: \(detPrice)"
        pDisc.text = "Product Discount: \(detDisc)"
        prodImg.image = image
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

