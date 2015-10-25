//
//  ViewController.swift
//  TLT_SIgn_in_app
//
//  Created by Samy on 10/17/15.
//  Copyright © 2015 Samy Achour. All rights reserved.
//

import Parse
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var personInfo: String = ""
    var items = [String]()
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var textFieldPerson: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addButton(sender: UIButton) {
        
        let newItem = textField.text
        let newInfo = textFieldPerson.text
        
        personInfo = newInfo!
        
        let dataString = addUnderscores(newItem!)
        
        //if the data that the user inputted is correct
        if (dataString != ""){
            
            updateDatabase(dataString, rowData: personInfo)
            
            items.insert(newItem! + " " + getDate(), atIndex: 0)
            textField.resignFirstResponder()
            
            textField.text = ""
            tableView.reloadData()
            
            saveCoreVariables()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadCoreVariables()
        
    }
    
    //update the Parse database
    func updateDatabase(columnName: String,rowData: String){
        
        let SIObject = PFObject(className: "SI_Sign_in")
        SIObject[columnName] = rowData
        SIObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in print("it worked")
            
        }
        
    }
    
    //Create an alert with a title, message, and dismiss button
    func alert(alertTitle: String,alertMessage: String){
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    //So we can convert "Bob Smith" to "bob_smith"
    func addUnderscores(var inputString: String) -> String{
        
        var returnString = ""
        
        //Check if the string contains a date with forward slashes
        if inputString != "" {
            
            //split string by the spaces, then join it by underscore
            let newItemArr = inputString.componentsSeparatedByString(" ")
            inputString = newItemArr.joinWithSeparator("_")
            
            returnString = inputString.lowercaseString
            
        } else {
            
            alert("Invalid entry", alertMessage: "Empty input")
        
        }
        
        return returnString
        
    }
    
    //Saves the variables we need to remember
    func saveCoreVariables(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(personInfo, forKey: "personInfo")
        defaults.setObject(items, forKey: "items")
        
    }
    
    //Loads the variables we need to remember
    func loadCoreVariables(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //if this is not the first time the user had loaded the app
        if (defaults.objectForKey("items") != nil){
            items = defaults.objectForKey("items") as? [String] ?? [String]()
        }
        if (defaults.objectForKey("personInfo") != nil){
            personInfo = defaults.objectForKey("personInfo") as! String
        }
        
        if personInfo != ""{
            textFieldPerson.text = personInfo
        }
        tableView.reloadData()
        
    }
    
    //Get current date and time for table data insertion
    func getDate() -> String {
        
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        return DateInFormat
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return items.count
        
    }
    
    //load the table view based off the items array
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
        
    }

}

