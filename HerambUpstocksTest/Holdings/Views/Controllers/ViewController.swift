//
//  ViewController.swift
//  HerambUpstocksTest
//
//  Created by Heramb on 16/02/24.
//

import UIKit
import Alamofire
import Foundation
import CollapsibleTableSectionViewController
import JProgressView

class ViewController: CollapsibleTableSectionViewController {

    var progessView = ProgressView() 
    var holdingsModel: UserHoldingResponse?
    var itemNameArray = ["Current Value:", "Total Investment:", "Today's Profit & Loss:", "Profit & Loss:"]
    var itemValueArray = ["₹178248","₹119223.60","₹12728","₹59024.4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progessView.StartAnimating(in: self.view)
        let nib = UINib(nibName: "HoldingsTableViewCell", bundle: nil)
        self._tableView.register(nib, forCellReuseIdentifier: "HoldingsTableViewCell")
        let nib1 =  UINib(nibName: "P&LTableViewCell", bundle: nil)
        self._tableView.register(nib1, forCellReuseIdentifier: "P_LTableViewCell")
        self.delegate = self
        callAPi()
    }

    func callAPi() {
        
        let headers : HTTPHeaders = []
        
        NetworkManager.shared.request(type: EndpointItem.getUserHoldings, method: .get, parameters:[:], headers:headers, interceptor: nil, vc:self) { data, error  in
            guard let data = data else {return}
            self.progessView.stopAnimating()
            do{
                let decoder = JSONDecoder()
                let json = try decoder.decode(UserHoldingResponse.self, from:data as! Data)
                self.holdingsModel = json
                self._tableView.reloadData()
            }catch{
                print(error.localizedDescription)
            }
        }
    }

}

extension ViewController: CollapsibleTableSectionDelegate {
    func numberOfSections(_ tableView: UITableView) -> Int {
        return 2
    }
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.holdingsModel?.userHolding?.count ?? 4
        } else {
            return self.itemNameArray.count
        }
    }
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HoldingsTableViewCell", for: indexPath) as! HoldingsTableViewCell
            cell.selectionStyle = .none
            cell.configure(selectedStock: self.holdingsModel?.userHolding?[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "P_LTableViewCell", for: indexPath) as! P_LTableViewCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            cell.selectionStyle = .none
            cell.itemNameLbl.text = self.itemNameArray[indexPath.row]
            cell.valueLbl.text = self.itemValueArray[indexPath.row]
            return cell
        }
    }
    func collapsibleTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 85
        } else {
            return 45
        }
       
    }
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Upstocks Holding"
        } else {
            return ""
        }
        
    }
    
    func collapsibleTableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 54
        } else {
            return 20
        }
    }
}
