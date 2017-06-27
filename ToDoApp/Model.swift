//
//  Model.swift
//  ToDoApp
//
//  Created by 正之 on 2017/06/25.
//  Copyright © 2017年 Sasakura Hirofumi. All rights reserved.
//

import UIKit
import CoreData

class Model {
    //coredateからデータの読み込み
    var dataArray:NSMutableArray = []
    let appDelegate:AppDelegate
    let context:NSManagedObjectContext
    let fetchRequest:NSFetchRequest<TaskData>

    func getData() -> NSMutableArray {
        return dataArray
    }
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
        fetchRequest = TaskData.fetchRequest()
    }
    
    func dataLoad() {
        dataArray.removeAllObjects()
        let fetchData = try! context.fetch(fetchRequest)
        if(!fetchData.isEmpty){
            print(fetchData)
            for i in 0..<fetchData.count{
                print(fetchData[i].taskname!)
                dataArray.add(fetchData[i].taskname!)
            }
        }
    }
    
    //coredataのデータ書き換え
    func dataChange(_ fromDataNo: intmax_t , _ toData: String){
        
    }
    
    //coredateのデータ削除
    func dataDelete() {
        
    }
    
    //coredateのデータ全削除
    func dataAllDelete() {
        let predicate = NSPredicate(format: "%K LIKE %@", "*" , "*")
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
    func dataAdd (_ addstr: String) {
        let taskdata = TaskData(context: context)
        taskdata.taskname = addstr
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    

}
