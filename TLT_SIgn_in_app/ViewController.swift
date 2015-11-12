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
        
        //Load the variables that are stored outside of the app
        loadCoreVariables()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(sender: UIButton) {
        
        let siName = textField.text!
        personInfo = textFieldPerson.text!
        
        personInfo = verifyPersonInfo(personInfo)
        let columnName = addUnderscores(siName)
        
        //If the user actually typed something in both text fields AND don't proceed if the SI Name has more than 1 space (see addUnderscores function) AND don't proceed if the personal info is not in the right format
        if (personInfo != "" && siName != "" && columnName != "" && personInfo != ""){
            
            updateDatabase(columnName, rowData: personInfo, tableRowString: siName)
            
        } else {
            
            alert("Invalid input", alertMessage: "Text field empty")
            
        }
        
    }
    
    // MARK: Updating data in Parse/Table function
    
    //Update the Parse database and Table cells
    //Parse uses UTC time
    //Note: This function is a mess. It's a mess because the parse documentation on swift is sparse at best. I probably should have went with objective-c but I did not know I would end up using parse. To summarize for any developers reading this, this function updates the parse database. If the SI name inputted does not exist already in the database it alerts the user. If the parse database cannot be connected to through the internet it alerts the user. If those alerts do not come up it edits the database correctly.
    func updateDatabase(columnName: String,rowData: String, tableRowString: String){
        
        //Get an object (row) from the database to see if the columnName input (SI Name) exists
        let query = PFQuery(className:"SI_Sign_in")
        query.getObjectInBackgroundWithId("LSkiYqNuPO") { (SISignin: PFObject?, error: NSError?) -> Void in
            
            //If the parse database was successfully connected to
            if error == nil && SISignin != nil {
                
                //Make a test object (row) and find out its value at the given columnName (SI Name)
                let test = SISignin![columnName]
                
                //If there is something at that column for our test object (row) then the SI Name already exists in the database and we can go ahead and update it!
                if (test != nil){
                    
                    //Create an object to input user data in given ColumnName at new row
                    let SIObject = PFObject(className: "SI_Sign_in")
                    SIObject[columnName] = rowData
                    SIObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                        
                        //If parse database was successfully connected to again
                        if success {
                            
                            //Adds latest value to the items array which the 'History' table loads from
                            self.items.insert(tableRowString + " " + self.getDate(), atIndex: 0)
                            self.textField.resignFirstResponder()
                            
                            //Makes the SI Name input text field blank again for further entries
                            self.textField.text = ""
                            //Reloads the table based off of global array
                            self.tableView.reloadData()
                            
                            self.saveCoreVariables()
                            
                        }
                        
                    }
                    
                //If the test object created gave us nil for it's value at the columnName (SI Name). Basically if there was no SI with that name in our database.
                } else {
                    
                    self.alert("SI Name", alertMessage: "SI name doesn't exist")
                    
                }
            
            //If the app could not successfully connect to the parse database
            } else {
                
                self.alert("Internet Connection!!!", alertMessage: "Could not add SI session to history because I couldn't connect to the database probably because of your internet connection")
                
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
    
    //Returns the amount of cells in the table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return items.count
        
    }
    
    //Toad the table view based off the items array
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
        
    }
    
    //When the user clicks on a tableview cell the SI name in that cell is put in the SI name textfield
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let autoCompleteString = items[indexPath.row]
        let returnString = autoCompleteString.componentsSeparatedByString(" ")
        
        //Just grab the first two words of the cell which happens to be the SI first+last name
        textField.text = returnString[0] + " " + returnString[1]
        
        //Deselect selected cell
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
    
    //So we can check the personal info to make sure it is in the right format "FirstName LastName IDNumber"
    func verifyPersonInfo(inputString: String) -> String{
        
        var returnString = ""
        
        let newItemArr = inputString.componentsSeparatedByString(" ")
        
        //Check if there are three words, the first two are strings, and the last one is an integer
        if newItemArr.count == 3 && Int(newItemArr[0]) == nil && Int(newItemArr[1]) == nil && Int(newItemArr[2]) != nil {
            
            returnString = inputString
            
        } else {
            
            alert("Personal Pnfo", alertMessage: "Your personal info should be in the following format: \"FirstName LastName IDNumber\"")
            
        }
        
        return returnString
        
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



