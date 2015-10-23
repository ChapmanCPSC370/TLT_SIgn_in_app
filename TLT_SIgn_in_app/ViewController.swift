//
//  ViewController.swift
//  TLT_SIgn_in_app
//
//  Created by Samy on 10/17/15.
//  Copyright © 2015 Samy Achour. All rights reserved.
//

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
        
        var newItemArr = newItem!.componentsSeparatedByString(" ")
        
        let firstName: String = newItemArr[0].lowercaseString
        let lastName: String = newItemArr[1].lowercaseString
        var date: String = newItemArr[2]
        
        if date.rangeOfString("/") != nil{
            
            var newDateArr = date.componentsSeparatedByString("/")
            
            date = newDateArr[0] + "_" + newDateArr[1] + "_" + newDateArr[2]
            
            let submitString = firstName + "_" + lastName + "_" + date
            
            print(submitString)
            
            //Add if statement to sql statement
            let sqlStatement = "INSERT INTO SI_sign_in (" + submitString + ") VALUES (\"" + personInfo + "\");"
            
            if (postToDatabase(sqlStatement) == "y"){
            
                items.append(newItem!)
                textField.resignFirstResponder()
            
                textField.text = ""
                textFieldPerson.text = personInfo
                tableView.reloadData()
            
                saveCoreVariables()
            
            } else {
                
                alert("Error", alertMessage: "Could not connect to database")
                
            }
            
        } else {
            
            alert("Date", alertMessage: "Invalid date input")
            
        }
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadCoreVariables()
        
    }
    
    func alert(alertTitle: String, alertMessage: String){
        
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func postToDatabase(sqlStatement: String) -> String{
        
        var returnVar = "n"
        returnVar = "y"
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://tltsigninapp.byethost7.com/service.php")!)
        request.HTTPMethod = "POST"
        let postString = "data=something"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                self.alert("Error", alertMessage: "error=\(error)")
                return
            }
            
            self.alert("PHP Script Responded", alertMessage: "response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.alert("Response", alertMessage: "responseString = \(responseString)")
        }
        task.resume()
        
        return returnVar
        
    }
    
    func saveCoreVariables(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(personInfo, forKey: "personInfo")
        defaults.setObject(items, forKey: "items")
        
    }
    
    func loadCoreVariables(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
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

