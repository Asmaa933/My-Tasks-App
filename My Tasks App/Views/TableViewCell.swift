//
//  TableViewCell.swift
//  My Tasks App
//
//  Created by AsMaa on 4/18/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    
    @IBOutlet weak var taskDescLabel: UILabel!
    
    @IBOutlet weak var taskDateLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(task: Tasks){
        taskNameLabel.text = task.taskName
        taskDescLabel.text = task.taskDesc
        

        taskDateLabel.text = task.taskDate?.convertDateToString(format: dateFormat)
        
    }

}
