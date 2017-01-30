//
//  PlaceDetailViewController.swift
//  GMPlaces_Swift_demo
//
//  Created by Seasia on 30/01/17.
//  Copyright © 2017 Seasia. All rights reserved.
//
//@Class: This class is use to show place detail
import UIKit

class PlaceDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var mDetailTableView: UITableView! // Show results for Google Place Detail API
    var placeId : String = ""
    var placeDetail : NSDictionary = NSDictionary() // Get result from Google Place Detail API
    var keyArray = ["name","url","icon"] // Contains which parameters to show
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Place Detail"
        self.callGoogleAPI(forString: placeId)
    }
    
    //MARK:- Table View Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
        let fieldString = keyArray[indexPath.row]
        let valueString : String? = placeDetail.value(forKey: keyArray[indexPath.row] ) as! String?
        
        if valueString != nil {
            tableCell.textLabel?.text = fieldString + " : " + valueString!
            
        }
        else
        {
            tableCell.textLabel?.text = fieldString + " : N/A"
        }
        
        
        
        return tableCell
    }
    
    
    func callGoogleAPI(forString : String)
    {
        let url = UrlForGooglePlaceDetailAPI(inputString: forString, key: GooglePlaceAPIKey)
        WebserviceHandler().getRequest(urlString: url, requestDict: [:], compBlock: { (response, satte) in
            print(response)
            let resultDict : [String : Any] = response as! [String : Any]
            let results  = resultDict["result"] as! NSDictionary
            self.placeDetail = results
            
            self.mDetailTableView.reloadData()
        }) { (errorDesc, state) in
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
