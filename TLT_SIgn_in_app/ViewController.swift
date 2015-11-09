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

    // MARK: Global core variables
    
    var personInfo: String = ""
    var items = [String]()
    
    // MARK: App utilities
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var textFieldPerson: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //load the variables that are stored outside of the app
        loadCoreVariables()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(sender: UIButton) {
        
        let siName = textField.text!
        personInfo = textFieldPerson.text!
                
        let columnName = addUnderscores(siName)
        
        //if the user actually typed something in both text fields
        if (personInfo != "" && siName != ""){
            
            updateDatabase(columnName, rowData: personInfo, tableRowString: siName)
            
        } else {
            
            alert("Invalid input", alertMessage: "Text field empty")
            
        }
        
    }
    
    // MARK: Updating data in Parse/Table function
    
    //Update the Parse database and Table cells
    func updateDatabase(columnName: String,rowData: String, tableRowString: String){
        
        let SIObject = PFObject(className: "SI_Sign_in")
        SIObject[columnName] = rowData
        SIObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            //if parse database was successfully updated
            //(Parse uses UTC time)
            if success {
                
                //Adds latest value to the items array which the 'History' table loads from
                self.items.insert(tableRowString + " " + self.getDate(), atIndex: 0)
                self.textField.resignFirstResponder()
                
                self.textField.text = ""
                self.tableView.reloadData()
                
                self.saveCoreVariables()
                
                //Implement if you want to start limiting personal data changes, make it a core variable
                //self.textFieldPerson.userInteractionEnabled = false
            
            //if parse database wasn't successfully updated
            } else {
                
                self.alert("Internet Connection!!!", alertMessage: "Could not add SI session to history and therefore could not update database. Please try again.")
                
            }
        
        }
        
    }
    
    // MARK: Core variable functions
    
    //Saves the variables we need to remember
    func saveCoreVariables(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(personInfo, forKey: "personInfo")
        defaults.setObject(items, forKey: "items")
        
    }
    
    //Loads the variables we need to remember
    func loadCoreVariables(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //If this is not the first time the user had loaded the app
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
    
    // MARK: Table View functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return items.count
        
    }
    
    //load the table view based off the items array
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
        
    }
    
    //When the user clicks on a tableview cell the SI name in that cell is put in the SI name textfield
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let autoCompleteString = items[indexPath.row]
        let returnString = autoCompleteString.componentsSeparatedByString(" ")
        
        textField.text = returnString[0] + " " + returnString[1]
        
        tableView.reloadData()
        
    }
    
    // MARK: Tools
    
    //Create an alert with a title, message, and dismiss button
    func alert(alertTitle: String,alertMessage: String){
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    //Get current date and time for table data insertion
    func getDate() -> String {
        
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        return DateInFormat
        
    }

    //So we can convert "Bob Smith" to "bob_smith"
    func addUnderscores(var inputString: String) -> String{
        
        var returnString = ""
        
        let newItemArr = inputString.componentsSeparatedByString(" ")
        
        //If there were more than two words in the SI name input
        if newItemArr.count > 2 {
                
            alert("SI Name", alertMessage: "The SI name should only have one space")
                
        } else {
                
            inputString = newItemArr.joinWithSeparator("_")
                
            returnString = inputString.lowercaseString
                
        }
        
        return returnString
        
    }

}



