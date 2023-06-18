//
//  ListView.swift
//  TodoList_swiftUIVer
//
//  Created by 방유빈 on 2023/06/17.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var modelData: ModelData
    @State var showAddView:Bool = false

    var body: some View {
        NavigationStack{
            List{
                ForEach(modelData.todoList){ todo in
                    //네비게이션 링크 화살표 없애기
                    ZStack{
                        NavigationLink{
                            DetailView(todo: todo)
                        }label: {}
                        .opacity(0)
                        HStack{
                            ListRow(todo: todo)
                        }
                    }
                }
                .onDelete(perform: removeRows)
                
            }
            .onAppear{
                modelData.todoList = modelData.loadTodo()
            }
            .onDisappear{
                modelData.saveTodo()
            }
            .navigationTitle("제발 좀 하자")
            .toolbar(){
                Button{
                    showAddView.toggle()
                }label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddView) {
                AddView(showAddView:$showAddView)
            }
        }
    }
    func removeRows(at offsets: IndexSet) {
        modelData.todoList.remove(atOffsets: offsets)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ModelData())
    }
}
