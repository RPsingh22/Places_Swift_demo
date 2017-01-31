//
//  PlaceDetailViewController.swift
//  GMPlaces_Swift_demo
//
//  Created by Cerebrum on 30/01/17.
//  Copyright © 2017 Cerebrum. All rights reserved.
//
//@Class: This class is use to show place detail
import UIKit

class PlaceDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var mDetailTableView: UITableView! // Show results for Google Place Detail API
    var placeId : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Place Detail"
        self.callGoogleAPI(forString: placeId)
    }
    
    //MARK:- Table View Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
        switch indexPath.row {
        case 0:
            tableCell.textLabel?.text = "name" + " : " + PlaceDetailObject.placeName!
        case 1:
            tableCell.textLabel?.text = "url" + " : " + PlaceDetailObject.placeUrl!
        case 2:
            tableCell.textLabel?.text = "icon" + " : " + PlaceDetailObject.placeIcon!
        default: break
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
            PlaceDetailObject.placeName = results.value(forKey: "name" ) as? String
            PlaceDetailObject.placeUrl  = results.value(forKey: "url" ) as? String
            PlaceDetailObject.placeIcon = results.value(forKey: "icon" ) as? String
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
