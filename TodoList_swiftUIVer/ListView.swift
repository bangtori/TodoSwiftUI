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
                
            }
            .navigationTitle("제발 좀 하자 ^_^")
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
