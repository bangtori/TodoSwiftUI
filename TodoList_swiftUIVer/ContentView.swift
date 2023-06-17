//
//  ContentView.swift
//  TodoList_swiftUIVer
//
//  Created by 방유빈 on 2023/06/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ListView()
            .environmentObject(ModelData())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
