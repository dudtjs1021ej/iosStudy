//
//  SynopsisTableViewCell.swift
//  BoxOffice
//
//  Created by 임영선 on 2021/09/30.
//

import UIKit

class SynopsisTableViewCell: UITableViewCell {

    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
