//
//  EditView.swift
//  TodoList_swiftUIVer
//
//  Created by 방유빈 on 2023/06/18.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var modelData:ModelData
    @State var updateTodo:Todo
    @State private var showSaveAlert:Bool = false
    var body: some View {
        NavigationStack{
            VStack(spacing:10){
                HStack{
                    Text("제 목")
                    TextField("할 일 제목 입력", text: $updateTodo.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.bottom)
                VStack{
                    Toggle(isOn: $updateTodo.checkDate){
                        Text("마감 시간 추가")
                    }
                    if updateTodo.checkDate {
                        DatePicker(
                            "날짜 및 시간 선택",
                            selection: $updateTodo.deadline,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .font(.body)
                    }
                }
                Divider()
                VStack(alignment:.leading){
                    Text("Memo")
                        .fontWeight(.bold)
                    TextEditor(text: $updateTodo.memo)
                        .border(Color.gray, width: 2)
                }
                Spacer()
                Button{
                    showSaveAlert.toggle()
                }label: {
                    Text("저장 하기")
                        .padding(.horizontal)
                }
                .alert("수정하기",isPresented: $showSaveAlert) {
                    Button("Yes", role: .destructive){
                        modelData.updateTodo(updateTodo)
                        dismiss()
                    }
                }message: {
                    Text("정말 이 일을 수정하시겠습니까?")
                }
                .disabled(updateTodo.title == "")
                .buttonStyle(.bordered)
            }
            .font(.title2)
            .padding()
            .navigationTitle("수정")

        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(updateTodo: Todo(title: "Todo List App 만들기", memo: "SwiftUI", deadline: Date(), checkDate: true, isChecked: false, isClip: false))
            .environmentObject(ModelData())
    }
}
