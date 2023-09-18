//
//  ContentView.swift
//  ClipStack
//
//  Created by Deathcode on 18/09/23.
//

import SwiftUI
import OnPasteboardChange

struct ContentView: View {
    @State var items = [CopiedItem]()
    
    var body: some View {
        VStack {
            if(items.isEmpty){
                VStack{
                    Text("Nothing's here 💭")
                }
                .font(.title)
                .padding()
            }else {
                List {
                    ForEach(items){ copiedItem in
                        Card(content: copiedItem.pasteboardContent){
                            if let index = items.firstIndex(of: copiedItem) {
                                items.remove(at: index)
                            }
                        }.onTapGesture {
                            let pasteboard = NSPasteboard.general
                            pasteboard.declareTypes([.string], owner: nil)
                            pasteboard.setString(copiedItem.pasteboardContent, forType: .string)
                        }
                    }
                }
                .listStyle(.inset)
                Spacer()
                HStack{
                    Button{
                        items.removeAll()
                    }label: {
                        Image(systemName: "xmark.bin.fill")
                            .foregroundColor(.accentColor)
                    }.buttonStyle(.borderless)
                        .padding()
                }
            }
        }
        .onPasteboardChange {
            if let lastestItem = NSPasteboard.general.pasteboardItems?.first {
                if let content = lastestItem.string(forType: .string) {
                    if let _ = items.firstIndex(where: { item in
                        item.pasteboardContent == content
                    }){
                        return
                    }else{
                        if(content.trim().isEmpty){
                            return
                        }
                        let copiedContent = CopiedItem(pasteboardContent: content)
                        items.insert(copiedContent, at: 0)
                    }
                }
            }
        }
    }
}


struct Card : View {
    let content: String
    var deleteAction: ()-> Void
    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(Color.accentColor.gradient)
                .cornerRadius(8)
            
            HStack {
                Text(content)
                    .font(.body)
                    .fontWeight(.regular)
                    .lineLimit(3)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
                Button{
                    deleteAction()
                }label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.white)
                        
                }.buttonStyle(.borderless)
                    .padding()
            }
        }
    }
}

struct CopiedItem: Identifiable, Equatable {
    let id: UUID = UUID()
    let pasteboardContent: String
}


extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
