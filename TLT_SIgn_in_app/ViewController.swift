//
//  ViewController.swift
//  TLT_SIgn_in_app
//
//  Created by Samy on 10/17/15.
//  Copyright © 2015 Samy Achour. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var items = [String]()
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addButton(sender: UIButton) {
        
        let newItem = textField.text
        
        var newItemArr = newItem!.componentsSeparatedByString(" ")
        
        var firstName: String = newItemArr [0]
        var lastName: String = newItemArr [1]
        var date: String = newItemArr [2]
        
        items.append(newItem!)
        textField.resignFirstResponder()
        
        textField.text = ""
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return items.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
        
    }

}

