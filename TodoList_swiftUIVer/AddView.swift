//
//  AddView.swift
//  TodoList_swiftUIVer
//
//  Created by 방유빈 on 2023/06/17.
//

import SwiftUI

struct AddView: View {
    @EnvironmentObject var modelData:ModelData
    @State private var title :String = ""
    @State private var memo :String = ""
    @State private var checkDate:Bool = false
    @State private var date: Date = Date()
    @Binding var showAddView : Bool
    @State private var showAddAlert:Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing:10){
                HStack{
                    Text("제 목")
                    TextField("할 일 제목 입력", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.bottom)
                VStack{
                    Toggle(isOn: $checkDate){
                        Text("마감 시간 추가")
                    }
                    if checkDate {
                        DatePicker(
                            "날짜 및 시간 선택",
                            selection: $date,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .font(.body)
                    }
                }
                Divider()
                VStack(alignment:.leading){
                    Text("Memo")
                        .fontWeight(.bold)
                    TextEditor(text: $memo)
                        .border(Color.gray, width: 2)
                }
                Spacer()
            }
            .font(.title2)
            .padding()
            .navigationTitle("할 일 추가")
            .toolbar {
                Button{
                    showAddAlert.toggle()
                }label: {
                    Text("추가")
                }
                .disabled(title == "")
                .alert("저장하기",isPresented: $showAddAlert) {
                    Button("Yes", role: .destructive){
                        addTodo()
                        showAddView.toggle()
                    }
                }message: {
                    Text("정말 이 일을 추가하시겠습니까?")
                }
            }
        }
    }
    func addTodo(){
        let newTodo:Todo = Todo(title: title, memo: memo, deadline: date, checkDate: checkDate, isChecked: false, isClip: false)
        modelData.todoList.insert(newTodo, at: modelData.todoList.count - modelData.checkCount)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(showAddView: .constant(true))
            .environmentObject(ModelData())
    }
}
