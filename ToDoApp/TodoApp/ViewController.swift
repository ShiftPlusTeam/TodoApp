//
//  ViewController.swift
//  TodoApp
//
//  Created by Sasakura Hirofumi on 2017/06/04.
//  Copyright © 2017 Sasakura Hirofumi. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    //CoerDataに関する各種情報を設定
    let ENTITY_NAME = "Todo"
    let ITEM_NAME = "text"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //CoreDataからデータをfetchする
        getCoreData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //plusButtonTapped的なメソッドの中身の
    let taskName = taskTextField.text
    
    //TextFieldに値が入っているか否か
    if taskName == "" {
    dismiss(animated: true, completion: nil)
    return
    }
    
    //contextを定義
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let task = Task(context: context)
    
    task.name = taskName
    task.category = taskCategory
    
    //作成したTask型のデータをプロパティに入力、選択したデータを代入します
    task.name = taskName
    task.category = taskCategory
    
    //作成したデータをDBに保存
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    dismiss(animated: true, completion: nil)
    
    
    
    //CoreDataを取得
    func getCoreData() {
        //データ保存と同時にcontextを定義
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        tasks = try context.fetch(fetchRequest)
        
    }


}

