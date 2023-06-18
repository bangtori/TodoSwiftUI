//
//  DetailVoew.swift
//  TodoList_swiftUIVer
//
//  Created by 방유빈 on 2023/06/17.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var modelData: ModelData
    var todo : Todo
    var body: some View {
        NavigationStack{
            VStack(){
                if todo.checkDate{
                    HStack{
                        Text("마감일")
                        Spacer()
                        Image(systemName: "calendar")
                        Text("\(dateFormatter(date:todo.deadline))")
                    }
                    .padding(.bottom)
                }
                VStack(alignment:.leading){
                    Text("Memo")
                        .font(.title2)
                        .fontWeight(.bold)
                    Divider()
                        .padding(.bottom)
                    Text(todo.memo)
                }
                Spacer()
                Button{
                    
                }label: {
                    Text("삭 제")
                        .font(.title2)
                        .foregroundColor(.red)
                }
            }
            .padding()
            .navigationTitle(todo.title)
            .toolbar{
                ToolbarItem (placement: .navigationBarTrailing){
                    NavigationLink{
                        EditView(updateTodo: todo)
                    }label: {
                        Text("수정")
                    }
                }

            }
        }
    }
    func dateFormatter(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd(EEE) HH:mm 까지"
        return formatter.string(from: date)
    }
}

struct DetailVoew_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(todo:Todo(title: "TodoList App 만들기", memo: "swiftUI로 구현", deadline: Date(), checkDate: true, isChecked: false, isClip: false))
    }
}
