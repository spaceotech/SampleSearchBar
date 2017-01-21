//
//  ViewController.swift
//  SampleSearchBar
//
//  Created by Hitesh on 1/21/17.
//  Copyright © 2017 spaceo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblSearch: UITableView!
    
    
    var isSearch : Bool = false
    var arrCountry = ["Afghanistan", "Algeria", "Bahrain","Brazil", "Cuba", "Denmark","Denmark", "Georgia", "Hong Kong", "Iceland", "India", "Japan", "Kuwait", "Nepal"];
    var arrFilter:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblSearch.dataSource = self
        self.tblSearch.delegate = self
        self.searchBar.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearch) {
            return arrFilter.count
        }
        return arrCountry.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forRowAtIndexPath: NSIndexPath) {
        if(isSearch){
            cell.textLabel?.text = arrFilter[forRowAtIndexPath.row]
        } else {
            cell.textLabel?.text = arrCountry[forRowAtIndexPath.row];
        }
    }
    
    
    //MARK: UISearchbar delegate
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        isSearch = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        arrFilter = arrCountry.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(arrFilter.count == 0){
            isSearch = false;
        } else {
            isSearch = true;
        }
        self.tblSearch.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

