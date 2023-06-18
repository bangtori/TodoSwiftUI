//
//  DetailVoew.swift
//  TodoList_swiftUIVer
//
//  Created by 방유빈 on 2023/06/17.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var modelData: ModelData
    @State private var showDeleteAlert:Bool = false
    var todo : Todo
    var body: some View {
        NavigationStack{
            VStack(){
                HStack{
                    Text("마감일")
                    Spacer()
                    Image(systemName: "calendar")
                    if todo.checkDate{
                        Text(modelData.dateFormatter(todo))
                    }
                    else{
                        Text("지정 안함")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.bottom)
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
                    showDeleteAlert.toggle()
                }label: {
                    Text("삭 제")
                        .font(.title2)
                        .foregroundColor(.red)
                }
                .alert("할 일 삭제",isPresented: $showDeleteAlert) {
                    Button("Yes", role: .destructive){
                        modelData.deleteTodo(todo)
                        dismiss()
                    }
                }message: {
                    Text("정말 이 일을 삭제하시겠습니까?")
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
}

struct DetailVoew_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(todo:Todo(title: "TodoList App 만들기", memo: "swiftUI로 구현", deadline: Date(), checkDate: true, isChecked: false, isClip: false))
            .environmentObject(ModelData())
    }
}
