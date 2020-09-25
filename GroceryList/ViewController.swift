//
//  ViewController.swift
//  GroceryList
//
//  Created by Jeremy Leworthy on 2020-09-25.
//

import UIKit

class groceryListCell: UITableViewCell {
    @IBOutlet weak var indicator: UIImageView!
    @IBOutlet weak var item: UILabel!
}

class groceryListItem {
    var checked: Bool
    var description: String
    init(checked: Bool, description: String) {
        self.checked = checked
        self.description = description
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblGroceryList: UITableView!
    @IBOutlet weak var txtGroceryItem: UITextField!
    @IBOutlet weak var addItemModal: UIView!
    var groceryList: [groceryListItem] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryListCell", for: indexPath) as! groceryListCell
        for item in 0...groceryList.count-1 {
            if indexPath.row == item {
                if groceryList[item].checked {
                    cell.indicator.image = UIImage(named: "checked")
                } else {
                    cell.indicator.image = UIImage(named: "unchecked")
                }
                cell.item.text = groceryList[item].description
                return cell
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryListCell", for: indexPath) as! groceryListCell
        for item in 0...groceryList.count-1 {
            if indexPath.row == item {
                if groceryList[item].checked {
                    cell.indicator.image = UIImage(named: "unchecked")
                    groceryList[item].checked = false
                } else {
                    cell.indicator.image = UIImage(named: "checked")
                    groceryList[item].checked = true
                }
            }
        }
        tblGroceryList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groceryList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        txtGroceryItem.text = ""
        addItemModal.isHidden = false
    }
    
    @IBAction func clearList(_ sender: UIButton) {
        groceryList.removeAll()
        tblGroceryList.reloadData()
    }
    
    @IBAction func add(_ sender: UIButton) {
        if txtGroceryItem.text!.count > 0 && txtGroceryItem.text != nil {
            groceryList.append(groceryListItem(checked: false, description: txtGroceryItem.text!))
            addItemModal.isHidden = true
        }
        tblGroceryList.reloadData()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        addItemModal.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

