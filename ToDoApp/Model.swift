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
    var dataArrayStr:NSMutableArray = []
    var dataArrayYet:NSMutableArray = []
    let appDelegate:AppDelegate
    let context:NSManagedObjectContext
    let fetchRequest:NSFetchRequest<TaskData>


    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
        fetchRequest = TaskData.fetchRequest()
    }
    
    func getData() -> NSMutableArray {
        return dataArrayStr
    }
    
    func getDoneYet() -> NSMutableArray {
        return dataArrayYet
    }
    
    func getData(_ dataNum: intmax_t) -> String {
        return dataArrayStr[dataNum] as! String
    }
    
    func getDoneYet(_ dataNum: intmax_t) -> Bool {
        return dataArrayYet[dataNum] as! Bool
    }
    
    //coredataからデータを読み込んで保存
    func dataLoad() {
        dataArrayStr.removeAllObjects()
        dataArrayYet.removeAllObjects()
        let fetchData = try! context.fetch(fetchRequest)
        if(!fetchData.isEmpty){
            print(fetchData)
            for i in 0..<fetchData.count{
                print(fetchData[i].taskname!)
                dataArrayStr.add(fetchData[i].taskname!)
                dataArrayYet.add(fetchData[i].taskyet)
            }
        }
    }
    
    //coredataのデータ(taskname)書き換え_未実装
    func dataChange(_ fromDataNo: intmax_t , _ toData: String){
        
    }
    
    //coredataのデータ(taskyet)書き換え
    func dataChange(_ dataNum: intmax_t){
        let fetchData = try! context.fetch(fetchRequest)
        if(!fetchData.isEmpty){
            print(fetchData)
            print("切替対象\(fetchData[dataNum].taskname!)")
            let changeObject = fetchData[dataNum] as TaskData
            if changeObject.taskyet{
                changeObject.taskyet = false
            }else{
                changeObject.taskyet = true
            }
            do{
                try context.save()
            }catch{
                print(error)
            }
        }

    }
    
    //coredateのデータ削除
    func dataDelete(_ dataNum: intmax_t) {
        let fetchData = try! context.fetch(fetchRequest)
        if(!fetchData.isEmpty){
            print(fetchData)
                print("削除対象\(fetchData[dataNum].taskname!)")
                let deleteObject = fetchData[dataNum] as TaskData
                context.delete(deleteObject)
            do{
                try context.save()
            }catch{
                print(error)
            }
        }
    }
    
    //coredateのデータ全削除
    func dataAllDelete() {
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
    func dataAdd (_ addstr: String) {
        let taskdata = TaskData(context: context)
        taskdata.taskname = addstr
        taskdata.taskyet = true
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    

}
