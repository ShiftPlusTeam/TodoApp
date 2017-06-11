//
//  ViewController.swift
//  ToDoApp
//
//  Created by Sasakura Hirofumi on 2017/06/03.
//  Copyright © 2017 Sasakura Hirofumi. All rights reserved.
//  HirofumiSasakura Kasahara

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //@IBOutlet var taskbord: [UItableView]!
    var myTasks: NSMutableArray = ["1" , "2" , "3" , "4" , "5"]
    var taskbord: UITableView!
    
    //@IBOutlet weak var taskbord: UITableView!
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskbord", for: indexPath as IndexPath)
        
        cell.textLabel!.text = "\(myTasks[indexPath.row])"
        return cell
    }
    
    @IBAction func taskadd(_ sender: UIButton) {
        myTasks.add("addtask")
        taskbord.reloadData()
    }
    
    
}


