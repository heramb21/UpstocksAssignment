//
//  HoldingsTableViewCell.swift
//  UpstocksAssignment
//
//  Created by Heramb on 16/02/24.
//

import UIKit

class HoldingsTableViewCell: UITableViewCell {
    
    // MARK: - Outletes
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var ltpLbl: UILabel!
    @IBOutlet weak var plLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Mark: - Cell Setup
    func configure(selectedStock: UserHolding?) {
        symbol.text = selectedStock?.symbol ?? ""
        quantityLbl.text = String(selectedStock?.quantity ?? 0)
        ltpLbl.text = String(format: "LTP:₹ \(selectedStock?.ltp ?? 0.0)")
        let investmentValue =  (selectedStock?.avgPrice ?? 0.0 * Double( selectedStock?.quantity ?? 0))
        let currentValue = (selectedStock?.ltp ?? 0.0 * Double(selectedStock?.quantity ?? 0))
        plLbl.text = String(format: "P/L:₹ %.2f", currentValue - investmentValue)
    }
    
}
