//
//  ViewController.swift
//  ToDoApp
//
//  Created by Sasakura Hirofumi on 2017/06/03.
//  Copyright © 2017 Sasakura Hirofumi. All rights reserved.
//  HirofumiSasakura Kasahara

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var myTasks: NSMutableArray = [] //タスク群を格納する配列
    var taskbord: UITableView!       //タスクを配置するテーブルビュー
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myTasks[indexPath.row])")
    }

    //セルの総数取得
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTasks.count
    }
    
    //各セルにタスク群を代入
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskbord", for: indexPath as IndexPath)
        
        cell.textLabel!.text = "\(myTasks[indexPath.row])"
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
                        print(textField.text!)
                        
                        self.myTasks.add(textField.text!)//ここでDBにレコードを追加
                        
                        self.taskbord.reloadData()
                    }
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


