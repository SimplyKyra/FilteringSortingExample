//
//  ItemDetail.swift
//  FilteringExample
//
//  Created by Kyra Delaney on 3/7/22.
//

import SwiftUI

struct ItemDetail: View {
    @Environment(\.managedObjectContext) var moc
    
    @State var item:Item?
    
    
    // Differentiate between add and edit. Unneeded on MacOS
    enum EditingState {
        case add, edit
    }
    var editingState = EditingState.add
    
    // Editable fields on form
    @State var name:String = ""
    @State var details:String = ""
    // Create Date Formatter
    @State var createdDate:Date?
    @State var updatedDate:Date?
    var body: some View {
        VStack {
            Form {
#if os(macOS)
                TextField("Name:", text: $name, prompt: Text("My Name"))
                TextField("Details:", text: $details, prompt: Text("About It!"))
#else
                HStack {
                    Text("Name:")
                    TextField("Name", text: $name)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Details:")
                    TextField("Details", text: $details)
                        .multilineTextAlignment(.trailing)
                }
#endif
                
                if createdDate == nil {
                    Text("No created date")
                } else {
                    Text("Created at: \(createdDate!, formatter: itemFormatter)")
                }
                
                if updatedDate == nil {
                    Text("No updated date")
                } else {
                    Text("Last Updated at: \(updatedDate!, formatter: itemFormatter)")
                }
                    
            }
        }
        .padding()
        .navigationTitle(name)
        
        // Look into a popup menu from bottom for this???
        HStack(spacing:10) {
            Button(action: {
                if item != nil {
                    moc.delete(item!)
                }
                try? moc.save()
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "trash.fill")
                    Text("Delete (⌘ d)")
                }
                .frame(maxWidth: .infinity)
            }
            .keyboardShortcut("d", modifiers: .command)
            
            Button(action: {
                saveItem()
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "checkmark")
                    Text("Save (⌘ s)")
                }
                .frame(maxWidth: .infinity)
            }
            .disabled(name.count == 0 || details.count == 0)
            .keyboardShortcut("s", modifiers: .command)
        } // End outer Vstack
        .onAppear() {
            loadItem()
        }
        .padding()
        
    }
    
    func loadItem() {
        if editingState == .edit {
            name = item!.name ?? ""
            details = item!.details ?? ""
            createdDate = item!.created
            updatedDate = item!.lastUpdated
        } else {
            createdDate = Date()
            updatedDate = Date()
        }
    }
    
    func saveItem() {
        if editingState == .add {
            let newItem = Item(context: moc)
            
            newItem.name = name
            newItem.details = details
            newItem.created = createdDate
            newItem.lastUpdated = updatedDate
            
            try? moc.save()
        } else if item != nil {
            item!.name = name
            item!.details = details
            item!.created = createdDate
            item!.lastUpdated = Date()
            try? moc.save()
        }
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail()
    }
}
