//
//  TableViewCell.swift
//  track app
//
//  Created by James Hunt on 4/11/19.
//  Copyright © 2019 James Hunt. All rights reserved.
//

import UIKit

class TBCellWeek: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabels: UILabel!
    
    
    
    
    let weekdays = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday"
    ]

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
//        timeLabel.font = UIFont(name: "SFMono-Regular", size: 14)
//        statusLabels.font = UIFont(name: "SFMono-Regular", size: 16)
        
        
        
    
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    
    

    
   
    
}
