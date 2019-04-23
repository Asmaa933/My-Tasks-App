//
//  ViewController.swift
//  My Tasks App
//
//  Created by AsMaa on 4/17/19.
//  Copyright © 2019 AsMaa. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var searchTxt: UITextField!
    
    @IBOutlet weak var tasksTable: UITableView!
    var savedTasks = [Tasks]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksTable.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    updateUI()
    }
    func updateUI() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tasksTable.register(nib, forCellReuseIdentifier: tasksCellID)
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedTasks = CoreDataHandler.getDataFromCoreData() ?? []
        tasksTable.reloadData()
    }

    @IBAction func searhBtnTapped(_ sender: Any) {
    savedTasks = CoreDataHandler.getspecificItemFromCoreData(itemName: searchTxt.text ?? "")
        if savedTasks.isEmpty{
            let alert = UIAlertController(title: "Alert!", message: "Cann't find this task ", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            { (action) in
                self.savedTasks = CoreDataHandler.getDataFromCoreData() ?? []
                self.tasksTable.reloadData()
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    tasksTable.reloadData()
    }
    
    @IBAction func textingInTxtBegin(_ sender: UITextField) {
        if sender.text?.isEmpty ?? false{
        savedTasks = CoreDataHandler.getDataFromCoreData() ?? []
        }else{
            savedTasks = CoreDataHandler.getspecificItemFromCoreData(itemName: searchTxt.text ?? "")
        }
            tasksTable.reloadData()
    
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension TasksViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tasksCellID, for: indexPath) as? TableViewCell else{
            print("cannot get cell")
            return UITableViewCell()
         
        }
        
      cell.configureCell(task: savedTasks[indexPath.row])
return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            savedTasks = CoreDataHandler.deleteObjectFromCoreData(task: savedTasks[indexPath.row]) ?? []
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
}
