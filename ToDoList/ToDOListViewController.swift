//
//  ViewController.swift
//  ToDoList
//

//

import UIKit

class ToDOListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addBarBtn: UIBarButtonItem!
    var toDoArray = ["Learn Swift", "Build App", "Change the word", "Take Pice"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    //強制有值
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "ShowDetail" {
    //            let destination = segue.destination as! DetailTableViewController
    //            let selectedIndexPath = tableView.indexPathForSelectedRow!
    //            destination.ToDoItem = toDoArray[selectedIndexPath.row]
    //        }
    //
    //    }
    //可選寫法 改問號？
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "ShowDetail" {
    //            if let destination = segue.destination as? DetailTableViewController {
    //                if let selectedIndexPath = tableView.indexPathForSelectedRow {
    //                    destination.ToDoItem = toDoArray[selectedIndexPath.row]
    //                }
    //            }
    //        }
    //    }
    
    //    @IBAction func unwindFormDetail(segue: UIStoryboardSegue) {
    //        if let souce = segue.source as? DetailTableViewController,
    //           let selectedIndexPath = tableView.indexPathForSelectedRow {
    //            toDoArray[selectedIndexPath.row] = souce.ToDoItem!
    //            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
    //        }
    //
    //    }
    /* 在修改後的程式碼中，感嘆號（!）已被替換為使用 if let 陳述式進行選擇性解包。這確保在使用前將選擇性值安全地解包。source.ToDoItem 現在使用選擇性綁定指派給 toDoItem 常數。如果任何選擇性值為 nil，則不會執行 if let 區塊內的程式碼。這有助於防止因強制解包 nil 值而導致的崩潰。*/
    
    
    /*
     這段程式碼是一個 unwindFromDetail 的方法，用於處理從詳細頁面返回主頁面的情況。
     它的功能是更新主頁面的資料來反映從詳細頁面傳遞過來的變更。

     程式碼中的 segue 參數代表了觸發此方法的 Segue，它是用於連接不同視圖控制器之間的過渡。
     這段程式碼使用了 segue.source 屬性來獲取觸發 Segue 的視圖控制器，
     並透過類型轉換（as? DetailTableViewController）
     確保它是 DetailTableViewController 的實例。

     接下來，
     程式碼使用 tableView.indexPathForSelectedRow
     來獲取當前選中行的 IndexPath，以便更新對應的資料。

     如果 segue.source 是 DetailTableViewController，
     
     且有有效的 selectedIndexPath 和 toDoItem 值，
     則代表從詳細頁面返回主頁面並傳遞了變更。
     這時，程式碼將更新 toDoArray 中指定位置的資料，
     然後使用 tableView.reloadRows(at: [selectedIndexPath], with: .automatic) 方法重新加載該行。

     如果上述條件不滿足，即按下加號跳轉到詳細頁面，
     並在該頁面的 textField 中輸入了文字，
     則在底部新增一個新的資料項。
     程式碼創建一個新的 IndexPath，
     將 toDoItem 添加到 toDoArray 中，
     並使用 tableView.insertRows(at: [newIndexPath], with: .bottom) 方法在表格視圖的底部插入一行。

     這樣，無論是從詳細頁面返回主頁面還是在詳細頁面新增項目，程式碼都會根據不同的情況更新主頁面的資料。
     
     
     在您提供的程式碼中，else 區塊的條件判斷是指當 if 條件判斷不滿足時，
     即表示當以下任何一個條件不成立時：

     source 不能被轉換為 DetailTableViewController。
     selectedIndexPath 為 nil。
     toDoItem 為 nil。
     換句話說，
     當任何一個條件不滿足時，
     程式碼將執行 else 區塊中的邏輯，
     即在按下加號並跳轉到詳細頁面後，在表格視圖的底部新增一個項目。

     我對之前的解釋再次深感抱歉，並感謝您的耐心指正。
     
     */
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        if let source = segue.source as? DetailTableViewController,
           let selectedIndexPath = tableView.indexPathForSelectedRow,
           let toDoItem = source.ToDoItem {
            toDoArray[selectedIndexPath.row] = toDoItem
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }else {
            // 按加號 在textField輸入的文字,會新增在底部 .buttom
            // 這IndexPath 一定要有 印出[0, 4]
            let newIndexPath = IndexPath(row: toDoArray.count, section: 0)
            print("new: \(newIndexPath)")
            if let source = segue.source as? DetailTableViewController,
               let toDoItem = source.ToDoItem {
                toDoArray.append(toDoItem)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
                //滾動到最底
                tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
            }
        }
        
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail",
           let destination = segue.destination as? DetailTableViewController,
           let selectedIndexPath = tableView.indexPathForSelectedRow {
            destination.ToDoItem = toDoArray[selectedIndexPath.row]
        } else { // 這段else 不是很懂 表示按加號跳轉頁面,但並不會顯示在textField
            if let selectedIndexPath = tableView.indexPathsForSelectedRows {
                for indexPath in selectedIndexPath {
                    // 取消選定的cell 但是我按加號 都沒選呀
                      tableView.deselectRow(at: indexPath, animated: true)
                    
                }
            }

        }
    }
    
    
    //用可选链和可选绑定的组合来简化代码，并进一步提高可读性
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "ShowDetail",
    //           let destination = segue.destination as? DetailTableViewController,
    //           let selectedIndexPath = tableView.indexPathForSelectedRow {
    //            destination.ToDoItem = toDoArray[selectedIndexPath.row]
    //        }
    //    }
    
    
    
    @IBAction func editBarBtnPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarBtn.isEnabled = true
            
            
        }else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBarBtn.isEnabled = false
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        

            
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = toDoArray[sourceIndexPath.row]
        toDoArray.remove(at: sourceIndexPath.row)
        toDoArray.insert(itemToMove, at: destinationIndexPath.row)
    }
 
    
    
}



extension ToDOListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection \(toDoArray.count)")
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath)
        cell.textLabel?.text = toDoArray[indexPath.row]
        
        return cell
        
    }
}

