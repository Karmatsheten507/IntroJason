//
//  jasonTableTableViewController.swift
//  IntroJasonTableView
//
//  Created by Nando Septian Husni on 5/28/18.
//  Copyright © 2018 imastudio. All rights reserved.
//

import UIKit

class jasonTableTableViewController: UITableViewController {
    
    
    // URL for Json
    
    let JsonURL = "http://api.kivaws.org/v1/loans/newest.json"
    
    // variable for loan swift
    
    var loans = [Loan] ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        getJsonLoan()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loans.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jsonCell", for: indexPath) as! JasonTableViewCell

        // Configure the cell...
        cell.LabelName.text = loans[indexPath.row].name
        cell.LabelCountry.text = loans[indexPath.row].country
        cell.LabelUse.text = loans[indexPath.row].use
        cell.LabelAmount.text = "S\(loans[indexPath.row].amount)"

        return cell
    }
    
// passing  the Json  Data into Swift
//creating a new method

    func getJsonLoan() {
        
        // declaring the url for this method
        guard let loanURL = URL(string: JsonURL)
            else{
                return
        }
        
                // return used to called the value our json when we called the varibale into the loanURL
        let request = URLRequest(url: loanURL)
        
        // declartion task to take your date from the vraibale of request URL
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let errors = error{
                print(errors)
                return
            }
            // passing the json data into swift
            // declaring the variable that is going to be called
            
            if let data = data{
                
                //passing json
                
                self.loans = self.parseJsonData(data : data)
                
                //reload a tableview
                OperationQueue.main.addOperation ({
                    //reload the data
                    self.tableView.reloadData()
                })
                
                
            }
        })
       // resuming the data json
        
        task.resume()
    }
    //the method to parse Json
    
    func  parseJsonData(data : Data) -> [Loan] {
        // declaring the varibale loan as an object from the loan.swift
        
        
        var loans = [Loan]()
        
        // looping to the json data that were gonna parse
        do{
            //declarin the ressult from taking the json data
            let jsonResult  = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            // declaring the json to all the array named loane
            let jsonLoans  = jsonResult?["loans"] as! [AnyObject]
            // it will keep taking the dtat from json as long as there is data in the json from the var json loan
            for jsonLoan in jsonLoans{
                
                let loan = Loan()
                
                loan.name = jsonLoan["name"] as! String
                loan.use = jsonLoan["use"] as! String
                loan.amount = jsonLoan["loan_amount"] as! Int
                let location = jsonLoan["location"] as! [String: AnyObject]
                
                loan.country = location["country"] as! String
                
                loans.append(loan)
                
                
                
                
            
        }
        
        }catch{ print(error)}
        return loans
}

}

