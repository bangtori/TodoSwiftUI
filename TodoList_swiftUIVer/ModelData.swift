//
//  TodoStore.swift
//  TodoList_swiftUIVer
//
//  Created by 방유빈 on 2023/06/17.
//

import Foundation

struct Todo:Identifiable{
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
    
    init(){
        todoList = [
            Todo(title: "Todo List App 만들기", memo: "SwiftUI", deadline: Date(), checkDate: false, isChecked: false, isClip: false)
        ]
    }
}
