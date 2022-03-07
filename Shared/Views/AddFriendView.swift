//
//  AddFriendView.swift
//  FilteringExample
//
//  Created by Kyra Delaney on 3/6/22.
//

import SwiftUI
import CoreData

struct AddFriendView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.presentationMode) var presentation

  @State private var name = ""
  @State private var meetingPlace = ""
  @State private var meetingDate = Date()
  @State private var nameError = false
  @State private var meetingPlaceError = false
  @State var avatarName = "person.circle.fill"
  @State var pickerPresented = false

  var friendId: NSManagedObjectID?
  let viewModel = AddFriendViewModel()

  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section {
            HStack {
              Image(systemName: avatarName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
                .foregroundColor(Color("rw-green"))

              Button {
                withAnimation {
                  pickerPresented = true
                }
              } label: {
                Image(systemName: "pencil.circle")
                  .resizable()
                  .frame(width: 50, height: 50)
              }
            }
          }
          Section("FRIEND INFO") {
            VStack {
              TextField(
                "Name",
                text: $name,
              prompt: Text("Name"))
              if nameError {
                Text("Name is required")
                  .foregroundColor(.red)
              }
            }
            VStack {
              TextField(
                "Place",
                text: $meetingPlace,
              prompt: Text("Meeting Place"))
              if meetingPlaceError {
                Text("Meeting Place is required")
                  .foregroundColor(.red)
              }
            }
            DatePicker(
              "Date",
              selection: $meetingDate)
          }
        }

        Button {
          if name.isEmpty || meetingPlace.isEmpty {
            nameError = name.isEmpty
            meetingPlaceError = meetingPlace.isEmpty
          } else {
            let values = FriendValues(
              name: name,
              meetingPlace: meetingPlace,
              meetingDate: meetingDate,
              avatarName: avatarName)

            viewModel.saveFriend(
              friendId: friendId,
              with: values,
              in: viewContext)
            presentation.wrappedValue.dismiss()
          }
        } label: {
          Text("Save")
            .foregroundColor(.black)
            .font(.headline)
            .frame(maxWidth: 300)
        }
        .tint(Color("rw-green"))
        .buttonStyle(.borderedProminent)
//        .buttonBorderShape(.roundedRectangle(radius: 5))
        .controlSize(.large)
      }
      .navigationTitle("\(friendId == nil ? "Add Bestie" : "Edit Bestie")")
      Spacer()
    }
    .sheet(isPresented: $pickerPresented) {
      SFSymbolSelectorView(
        isPresented: $pickerPresented,
        selectedSymbolName: $avatarName)
    }
    .onAppear {
      guard
        let objectId = friendId,
        let friend = viewModel.fetchFriend(for: objectId, context: viewContext)
      else {
        return
      }

      meetingPlace = friend.meetingPlace
      name = friend.name
      meetingDate = friend.meetingDate
      avatarName = friend.avatarName
    }
  }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView()
    }
}
