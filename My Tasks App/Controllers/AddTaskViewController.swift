//
//  AddTaskViewController.swift
//  My Tasks App
//
//  Created by AsMaa on 4/18/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskDatePicker: UIDatePicker!
    @IBOutlet weak var taskDescTxt: UITextField!
    @IBOutlet weak var taskNameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        let task = Tasks(context: CoreDataHandler.getCoreDataobject())
        task.taskName = taskNameTxt.text ?? "No name"
        task.taskDesc = taskDescTxt.text ?? "No desc"
        task.taskDate = taskDatePicker.date 
        
        CoreDataHandler.saveIntoCoreData(taskItem: task)
    self.navigationController?.popViewController(animated: true)
    }
    
}
