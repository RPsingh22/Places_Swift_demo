//
//  SearchViewController.swift
//  GMPlaces_Swift_demo
//
//  Created by Cerebrum on 30/01/17.
//  Copyright © 2017 Cerebrum. All rights reserved.
//
//@Class: This class is use for search place from Google API.

import UIKit

class SearchViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var mSearchTextField: UITextField! // Textfield to search place
    @IBOutlet var mResultTableView: UITableView! // Show results in list from search string
    @IBOutlet var mResultTableHeightConstant: NSLayoutConstraint!
    
    var searchResultArray : NSMutableArray = NSMutableArray() // Get result from Google Place API
    var selectedPlaceID : String = ""
    
    // MARK: View methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Place"
        
        //Enable Accessibility of tableview and add Accessibility identifier for accesing in unit test case
        mResultTableView.isAccessibilityElement     =   true
        mResultTableView.accessibilityIdentifier    =   "searchResultTable"
    }
    
    
    // MARK: Textfield Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.characters.count == 0 {
            searchResultArray.removeAllObjects()
        }
        if let swRange = textField.text?.rangeFromNSRange(nsRange: range)
        {
            let searchString = textField.text?.replacingCharacters(in: swRange, with: string)
            if (searchString?.characters.count)! > 0 {
                //Hit API
                self.callGoogleAPI(forString: searchString!)
            }
            else{
                //Hide Table
                self.mResultTableView.isHidden = true
            }
        }
        return true
    }
    
    //MARK:- Table View Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableCellIdentifier")!
        
        let place = self.searchResultArray[indexPath.row] as! JsonResponsePlaceModel
        
        tableCell.textLabel?.text = place.placeDescription
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = self.searchResultArray[indexPath.row] as! JsonResponsePlaceModel
        let placeId = place.placeId
        selectedPlaceID = placeId!
        self.performSegue(withIdentifier: "SearchToDetailSegue", sender: self)
    }
    
    
    
    //MARK:- API HAndler Method For get Places auto complete
    
    func callGoogleAPI(forString : String)
    {
        let url = UrlForGoogleAPI(inputString: forString, key: GooglePlaceAPIKey)
        WebserviceHandler().getRequest(urlString: url, requestDict: [:], compBlock: { (response, satte) in
            print(response)
            let resultDict : [String : Any] = response as! [String : Any]
            let results  = resultDict["predictions"] as! NSArray
            self.searchResultArray.removeAllObjects()
            for index in 0..<results.count {
                let modelPlace = JsonResponsePlaceModel()
                if((results[index] as! NSDictionary)["description"] is String) {
                    modelPlace.placeDescription = (results[index] as! NSDictionary)["description"] as? String
                }
                if((results[index] as! NSDictionary)["place_id"] is String) {
                    modelPlace.placeId = (results[index] as! NSDictionary)["place_id"] as? String
                }
                self.searchResultArray.add(modelPlace)
            }
            self.mResultTableView.isHidden = false
            self.mResultTableView.reloadData()
        }) { (errorDesc, state) in
            
        }
        
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SearchToDetailSegue"
        {
            let placeDetailVC : PlaceDetailViewController = (segue.destination as? PlaceDetailViewController)!
            placeDetailVC.placeId = selectedPlaceID
        }
    }
    
    // MARK: Memory Management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
