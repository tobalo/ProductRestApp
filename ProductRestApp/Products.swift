//
//  Products.swift
//  CristobalTorres-CooperCarlson-Assignment5
//
//  Created by Somnio on 11/28/17.
//  Copyright © 2017 CristobalTorresValderas. All rights reserved.
//

import Foundation
import UIKit

class Products
{
    
    var id:Int = 0
    var name:String = ""
    var listPrice:Int = 0
    var discount:Int = 0
    var salePrice:Int = 0
    
    
    init(i:Int, n:String, lp:Int, disc:Int)
    {
        self.id = i
        self.name = n
        self.listPrice = lp
        self.discount = disc
    }
    
    func computeSalePrice(){
        salePrice = listPrice - discount
    
    }





}
