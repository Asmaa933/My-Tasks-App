//
//  AddTaskViewController.swift
//  My Tasks App
//
//  Created by AsMaa on 4/18/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit
import UserNotifications


class AddTaskViewController: UIViewController {
    //Outlets
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    @IBOutlet weak var taskDescTxt: UITextField!
    @IBOutlet weak var taskNameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 2) {
        self.taskNameTxt.alpha = 1
            self.taskDescTxt.alpha = 1
        }
  // Do any additional setup after loading the view.
    }
    // save new task after press done
    @IBAction func doneBtnTapped(_ sender: Any) {
        let task = Tasks(context: CoreDataHandler.getCoreDataobject())
        task.taskName = taskNameTxt.text ?? "No name"
        task.taskDesc = taskDescTxt.text ?? "No desc"
        task.taskDate = taskDatePicker.date
        giveAlertForTask()
        CoreDataHandler.saveIntoCoreData(taskItem: task)
        self.navigationController?.popViewController(animated: true)
    }
    func giveAlertForTask() {
        let content = UNMutableNotificationContent()
        content.title = taskNameTxt.text ?? ""
        content.body = taskDescTxt.text ?? ""
        content.badge = 1
        content.sound = .default
  //     let dateComponents = taskDatePicker.calendar.dateComponents([.day,.month,.year], from: taskDatePicker.date)
       // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "N1", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error == nil {
            print ("Notification Appear")
            }
        }
    }
}


