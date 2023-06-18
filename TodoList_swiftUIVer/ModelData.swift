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
    @Published var checkCount = 0
    @Published var pinCount = 0

    func updateCounts(){
        checkCount = todoList.filter {$0.isChecked}.count
        pinCount = todoList.filter {$0.isClip}.count
    }
    
    func updateTodo(_ todo:Todo){
        guard let idx = todoList.firstIndex(where: { $0.id == todo.id })else{ return }
        todoList[idx] = todo
        saveTodo()
    }
    func deleteTodo(_ todo:Todo){
        guard let idx = todoList.firstIndex(where: { $0.id == todo.id })else{ return }
        todoList.remove(at: idx)
        saveTodo()
    }
    
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
                return saveData
            }
        }
        return []
    }
    
    func checkPin(todo:Todo){
        guard let idx = todoList.firstIndex(where: { $0.id == todo.id })else{ return }
        let insertIdx:Int
        var updateTodo = todoList[idx]
        updateTodo.isClip.toggle()
        
        if updateTodo.isClip{
            //고정 시키면
            insertIdx = pinCount
            pinCount += 1
        }else{
            //고정 해제 시
            if todo.isChecked {
                //완료 항목이면 완료 항목쪽으로
                insertIdx = todoList.count - checkCount
            }else{
                //아니면 그냥 핀 밑
                insertIdx = pinCount-1
            }
            pinCount -= 1
        }
        todoList.remove(at: idx)
        todoList.insert(updateTodo, at: insertIdx)
    }
    
    func checkComplete(todo:Todo){
        guard let idx = todoList.firstIndex(where: { $0.id == todo.id })else{ return }
        let insertIdx:Int
        let listCnt:Int = todoList.count
        var updateTodo = todoList[idx]
        updateTodo.isChecked.toggle()

        if updateTodo.isChecked {
            //체크상태로 바꿀 때
            insertIdx = listCnt - (checkCount+1)
            checkCount += 1
        }else{
            //체크 해제할 때
            if todo.isClip {
                //고정 항목이라면
                insertIdx = 0
            }else{
                insertIdx = listCnt - checkCount
            }
            checkCount -= 1
        }
        todoList.remove(at: idx)
        todoList.insert(updateTodo, at: insertIdx)
    }
    
    func dateFormatter(_ todo:Todo) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd(EEE) HH:mm 까지"
        return formatter.string(from: todo.deadline)
    }
}
