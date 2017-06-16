//
//  ViewController.swift
//  ToDoApp
//
//  Created by Sasakura Hirofumi on 2017/06/03.
//  Copyright © 2017 Sasakura Hirofumi. All rights reserved.
//  HirofumiSasakura Kasahara

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var taskDataArray: NSMutableArray! = [] //タスク群を格納する配列
    var taskbord: UITableView!       //タスクを配置するテーブルビュー

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.dataLoad()
        
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成(Status barの高さをずらして表示).
        taskbord = UITableView(frame: CGRect(x: 0, y: barHeight + 50, width: displayWidth, height: displayHeight))

        taskbord.register(UITableViewCell.self, forCellReuseIdentifier: "taskbord")
        
        taskbord.dataSource = self
        taskbord.delegate = self
        
        self.view.addSubview(taskbord)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //coredateからデータの読み込み
    func dataLoad() {
        taskDataArray.removeAllObjects()
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDelegate.managedObjectContext
        let fetchRequest:NSFetchRequest<TaskData> = TaskData.fetchRequest()
        //var nameList:Array<String> = []
        let fetchData = try! context.fetch(fetchRequest)
        if(!fetchData.isEmpty){
            print(fetchData)
            for i in 0..<fetchData.count{
                print(fetchData[i].taskname!)
                taskDataArray.add(fetchData[i].taskname!)
            }
        }
    }
    
    //coredateのデータ削除
    func dataDelete() {
    
    }
    
    //coredateのデータ全削除
    func dataAllDelete() {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDelegate.managedObjectContext
        let fetchRequest:NSFetchRequest<TaskData> = TaskData.fetchRequest()
        let predicate = NSPredicate(format: "%K LIKE %@", "taskname" , "*")
        fetchRequest.predicate = predicate
        let fetchData = try! context.fetch(fetchRequest)
        if(!fetchData.isEmpty){
            print(fetchData)
            for i in 0..<fetchData.count{
                print("削除対象\(fetchData[i].taskname!)")
                let deleteObject = fetchData[i] as TaskData
                context.delete(deleteObject)
            }
            do{
                try context.save()
            }catch{
                print(error)
            }
        }
    }
    
    //coredateへのデータ追加
    func dataAdd (_ taskText: String) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDelegate.managedObjectContext
        let taskdata = TaskData(context: context)
        taskdata.taskname = taskText
        do{
            try context.save()
        }catch{
            print(error)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(taskDataArray[indexPath.row])")
    }

    //セルの総数取得
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskDataArray.count
    }
    
    //各セルにタスク群を代入
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskbord", for: indexPath as IndexPath)
        
        cell.textLabel!.text = "\(taskDataArray[indexPath.row])"
        return cell
    }
    
    //「＋」ボタン押下時のアクション
    @IBAction func taskadd(_ sender: UIButton) {
        
        //アラートのステータス
        let alert = UIAlertController(
            title: "",
            message: "追加するタスク名を入力してください",
            preferredStyle: .alert)
        
        // アラートのOKボタンステータス
        let okAction = UIAlertAction(title: "OK" , style: .default , handler: {(action: UIAlertAction!) -> Void in
            
            //OKボタン押下でテキスト取得
                if let textFields = alert.textFields{
                    for textField in textFields {
                        let taskText = textField.text
                        print("test\(taskText!)")
                        if (taskText == ""){
                            print("cansel")
                        }
                        else if (taskText == "alldelete"){
                            self.dataAllDelete()
                        }else{
                            self.dataAdd(textField.text!)
                        }
                    }
                    self.dataLoad()
                    self.taskbord.reloadData()
                }
            }
        )
        alert.addAction(okAction)
        
        //アラートのキャンセルボタンステータス
        let cancelAction = UIAlertAction(title: "キャンセル" , style: .cancel , handler: nil)
        alert.addAction(cancelAction)
        
        //アラートのテキストフィールド
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "テキスト"
        })
        
        //魔法の言葉
        alert.view.setNeedsLayout()
        
        // アラート表示
        self.present(alert, animated: true, completion: nil)
    }
}


