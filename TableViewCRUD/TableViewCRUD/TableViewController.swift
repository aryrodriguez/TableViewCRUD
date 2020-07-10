//
//  TableViewController.swift
//  TableViewCRUD
//
//  Created by Ary on 02/06/2020.
//  Copyright © 2020 Ary. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var colors = ["Red", "Green", "Blue"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return colors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = colors[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { action, indexPath in
           
            self.colors.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        })
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: {action, indexPath in
            
            let editController = UIAlertController(title: nil, message: "Edit Color", preferredStyle: .alert)
            editController.addTextField(configurationHandler: {
                
                (textfield) in textfield.text = self.colors[indexPath.row]
            })
            
            editController.addAction(UIAlertAction(title: "Save", style: .default, handler: {Action in
                
                let colorName = (editController.textFields?.first)?.text
                self.colors[indexPath.row] = colorName!
                tableView.reloadRows(at: [indexPath], with: .fade)
               
            }))
            
            editController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(editController, animated: true)
            
        })
        
        return [deleteAction, editAction]
    }
    
    @IBAction func addAction(_ sender: UIBarButtonItem)
    {
        let inputController = UIAlertController(title: nil, message: "New color", preferredStyle: .alert)
        
        inputController.addTextField(configurationHandler: {
            
            (textField) in textField.placeholder = "Name"
        })
        
        inputController.addAction(UIAlertAction(title: "OK", style: .default, handler: {Action in
            
            let colorName = (inputController.textFields!.first!).text!
            let index = self.colors.endIndex
            self.colors.append(colorName)
           // let index = self.colors.firstIndex(of: colorName)
            self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .top)
        }))
        
        inputController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(inputController, animated: true)
    }
    
}
