//
//  NewDreamView.swift
//  DreamHub
//
//  Created by Yi Ling on 7/4/25.
//

import Foundation
import SwiftUI

struct NewDreamView: View {
    @State var coreAppModel: CoreAppModel
    @State var date: Date
    @State var dreamName = ""
    @State var dreamContent = ""
    
    var body: some View {
        VStack{
            Image(systemName: "square.and.pencil.circle.fill")
            TextField("Give ur dream a name", text: $dreamName)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(height: 50)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            TextEditor(text: $dreamContent)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(height: 150)
                .padding(.horizontal, 20)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            Button(action: {
                let newDream = DreamModel()
                coreAppModel.dreamsList.append(newDream)
                dreamName = ""
                dreamContent = ""
            }, label: {
                Text("Save")
            })
        }
            .padding(.horizontal, 60)
    }
}
