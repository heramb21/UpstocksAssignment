//
//  P&LTableViewCell.swift
//  HerambUpstocksTest
//
//  Created by Heramb on 16/02/24.
//

import UIKit

class P_LTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
