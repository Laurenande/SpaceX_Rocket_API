//
//  TableCell.swift
//  InfoRocketSpaceX
//
//  Created by Егор Куракин on 18.05.2022.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var combustionValue: UILabel!
    @IBOutlet weak var fuelValue: UILabel!
    @IBOutlet weak var engineValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(titleRow: Int, value:(eng:String, fuel: String, combustion:String)){
        switch titleRow {
        case 1:
            titleLabel.text = "ПЕРВАЯ СТУПЕНЬ"
        case 2:
            titleLabel.text = "ВТОРАЯ СТУПЕНЬ"
        default:
            break
        }
        engineValue.text = value.eng
        fuelValue.text = value.fuel
        combustionValue.text = value.combustion
    }
    
}
