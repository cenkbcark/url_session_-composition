//
//  KategorilerTableViewCell.swift
//  udemy_composition_api
//
//  Created by Cenk Bahadır Çark on 9.08.2022.
//

import UIKit

class KategorilerTableViewCell: UITableViewCell {

    @IBOutlet weak var kategorilerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
