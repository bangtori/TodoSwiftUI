//
//  ListRow.swift
//  TodoList_swiftUIVer
//
//  Created by 방유빈 on 2023/06/17.
//

import SwiftUI

struct ListRow: View {
    @EnvironmentObject private var modelData:ModelData
    @State private var isChecked:Bool
    @State private var isClip:Bool
    var todo:Todo

    init(todo:Todo){
        self.todo = todo
        //@State를 가진 속성을 외부에서 값을 가져와 생성시 주입
        _isChecked = State(initialValue: todo.isChecked)
        _isClip = State(initialValue: todo.isClip)
    }
    var body: some View {
        HStack(){
            Button{
                isChecked.toggle()
                modelData.checkComplete(todo: todo)
            }label: {
                Image(systemName: isChecked ? "checkmark.circle.fill":"circle")
                
            }
            .buttonStyle(.plain)
            .font(.title)
            .padding(.trailing)
            VStack(alignment: .leading){
                //title 부분
                if isChecked {
                    Text(todo.title)
                        .foregroundColor(.gray)
                        .strikethrough()
                        .fontWeight(.bold)
                }else{
                    Text(todo.title)
                        .fontWeight(.bold)

                }
                //마감일 부분
                if todo.checkDate {
                    HStack{
                        Image(systemName: "calendar")
                        Text(modelData.dateFormatter(todo))
                    }
                    .foregroundColor(isChecked ? .gray : .black)
                }
                
            }
            .padding(.vertical)
            Spacer()
            Button{
                isClip.toggle()
                modelData.checkPin(todo: todo)
            }label: {
                Image(systemName: isClip ? "pin.fill":"pin")
            }
            .buttonStyle(.plain)
            .font(.title)
            .foregroundColor(.red)
        }
    }

}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(todo: Todo(title: "Todo List App 만들기", memo: "SwiftUI", deadline: Date(), checkDate: true, isChecked: false, isClip: false))
            .environmentObject(ModelData())
    }
}
