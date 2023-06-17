//
//  TodoStore.swift
//  TodoList_swiftUIVer
//
//  Created by 방유빈 on 2023/06/17.
//

import Foundation

struct Todo:Identifiable, Codable{
    var id = UUID()
    var title:String
    var memo:String
    var deadline:Date
    var checkDate:Bool
    var isChecked:Bool
    var isClip:Bool
}

class ModelData:ObservableObject{
    @Published var todoList: [Todo] = []
    func saveTodo(){
        let encoder:JSONEncoder = JSONEncoder()
        if let encoded = try? encoder.encode(todoList){
            UserDefaults.standard.set(encoded, forKey: "todo")
        }
    }
    func loadTodo()->[Todo]{
        let decoder:JSONDecoder = JSONDecoder()
        if let data = UserDefaults.standard.object(forKey: "todo") as? Data{
            if let saveData = try? decoder.decode([Todo].self, from: data){
                print(saveData)
                return saveData
            }
        }
        return []
    }
    func checkPin(){
        
    }
}
