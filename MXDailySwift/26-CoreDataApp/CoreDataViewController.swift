//
//  CoreDataViewController.swift
//  DailySwift
//
//  Created by mx_in on 2017/12/1.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UITableViewController {

    let entityName = "ListEntity"
    let itemKey = "item"
    var cdManager = CoreDataManager()
    var listItems = [NSManagedObject]()
    
    let cellIdentify = "CDCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem(sender:)))

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
        
        do {
            let results = try cdManager.managedObjectContext.fetch(fetchRequest)
            listItems = results
            self.tableView.reloadData()
        } catch {
            
            print("error")
        }
    }
    
    @objc func addItem(sender: UIButton) {
        let alertController = UIAlertController(title: "New Resolution", message: "", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "confirm", style: .default) { _ in
            if let fields = alertController.textFields {
                let text = fields[0].text!
                self.saveItem(text)
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertController.addTextField {
            $0.placeholder = "Type somethings"
        }
        
        [confirmAction, cancelAction].forEach { action in
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveItem(_ itemToSaved: String) {
        let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: cdManager.managedObjectContext)
        let item = NSManagedObject(entity: entity!, insertInto: cdManager.managedObjectContext)
        item.setValue(itemToSaved, forKey: itemKey)
        
        do {
            try cdManager.managedObjectContext.save()
            listItems.append(item)
        } catch {
            print("error")
        }
        
    }
}

extension CoreDataViewController {
    // MARK: - DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify, for: indexPath)
        let item = listItems[indexPath.row]
        cell.textLabel?.text = item.value(forKey: itemKey) as? String
        cell.textLabel?.font = UIFont(name: "", size: 25)
        
        return cell
    }

    // MARK: - Delagate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "delete") { (action, index) in
            
            tableView.reloadRows(at: [indexPath], with: .left)
            self.cdManager.managedObjectContext.delete(self.listItems[indexPath.row])
            
            do {
                try self.cdManager.managedObjectContext.save()
                self.listItems.remove(at: indexPath.row)
                self.tableView.reloadData()
            } catch {
                print("error: delete")
            }
        }
        
        return [delete]
    }
    
}
