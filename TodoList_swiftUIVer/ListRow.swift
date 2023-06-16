//
//  ListRow.swift
//  TodoList_swiftUIVer
//
//  Created by 방유빈 on 2023/06/17.
//

import SwiftUI

struct ListRow: View {
    @State private var isChecked:Bool
    @State private var isClip:Bool
    private var todo:Todo

    init(todo:Todo){
        self.todo = todo
        _isChecked = State(initialValue: todo.isChecked)
        _isClip = State(initialValue: todo.isClip)
    }
    var body: some View {
        HStack{
            Button{
                isChecked.toggle()
            }label: {
                Image(systemName: isChecked ? "checkmark.circle.fill":"circle")
            }
            .buttonStyle(.plain)
            .font(.title)
            VStack(alignment: .leading){
                //title 부분
                if isChecked {
                    Text(todo.title)
                        .foregroundColor(.gray)
                        .strikethrough()
                        .font(.title)
                        .fontWeight(.bold)
                }else{
                    Text(todo.title)
                        .font(.title)
                        .fontWeight(.bold)
                }
                //마감일 부분
                if todo.checkDate {
                    HStack{
                        Image(systemName: "calendar.circle")
                        Text(dateFormatter(date: todo.deadline))
                    }
                }
                
            }
            Button{
                isClip.toggle()
            }label: {
                Image(systemName: isClip ? "pin.fill":"pin")
            }
            .buttonStyle(.plain)
            .font(.title)
            .foregroundColor(.red)
            .padding()
        }
    }
    func dateFormatter(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd HH:mm"
        return formatter.string(from: date)
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(todo: Todo(title: "Todo List App 만들기", memo: "SwiftUI", deadline: Date(), checkDate: true, isChecked: false, isClip: false))
    }
}
