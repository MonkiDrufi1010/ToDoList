//
//  DetailTableViewController.swift
//  ToDoList

//

import UIKit

class DetailTableViewController: UITableViewController {

    
    @IBOutlet weak var saveBarbBtn: UIBarButtonItem!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var noteView: UITextView!
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    var ToDoItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ToDoItem == nil {
            nameField.text = ""
        }else {
            nameField.text = ToDoItem
        }
        

    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ToDoItem = nameField.text
    }
    
    @IBAction func cencelBarBtn(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        }else {
            //navig 推回上一頁 要用 pop
//            dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        }
        
    }
 

   

    
}
