/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @State private var addViewShown = false
  let viewModel = ListViewModel()

  // 1
  @SectionedFetchRequest(
    // 2
    sectionIdentifier: FriendSort.default.section,
    // 3
    sortDescriptors: FriendSort.default.descriptors,
    // 4
    animation: .default)
  // 5
  private var friends: SectionedFetchResults<String, Friend>
  @State private var selectedSort = FriendSort.default
  @State private var searchTerm = ""
  var searchQuery: Binding<String> {
    Binding {
      // 1
      searchTerm
    } set: { newValue in
      // 2
      searchTerm = newValue

      // 3
      guard !newValue.isEmpty else {
        friends.nsPredicate = nil
        return
      }

      // 4
      friends.nsPredicate = NSPredicate(
        format: "name contains[cd] %@",
        newValue)
    }
  }

  var body: some View {
    NavigationView {
      List {
        // 1
        ForEach(friends) { section in
          // 2
          Section(header: Text(section.id)) {
            // 3
            ForEach(section) { friend in
              NavigationLink {
                AddFriendView(friendId: friend.objectID)
              } label: {
                FriendView(friend: friend)
              }
            }
            .onDelete { indexSet in
              withAnimation {
                // 4
                viewModel.deleteItem(
                  for: indexSet,
                  section: section,
                  viewContext: viewContext)
              }
            }
          }
        }
      }
      .searchable(text: searchQuery)
      .toolbar {
        // 1
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          // 2
          SortSelectionView(
            selectedSortItem: $selectedSort,
            sorts: FriendSort.sorts)
          // 3
          .onChange(of: selectedSort) { _ in
            let request = friends
            request.sortDescriptors = selectedSort.descriptors
            request.sectionIdentifier = selectedSort.section
          }
          // 4
          Button {
            addViewShown = true
          } label: {
            Image(systemName: "plus.circle")
          }
        }
      }
      .sheet(isPresented: $addViewShown) {
        AddFriendView()
      }
      .navigationTitle("Besties")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
