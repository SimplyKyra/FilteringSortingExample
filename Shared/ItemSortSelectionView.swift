//
//  ItemSortSelectionView.swift
//  FilteringExample
//
//  Created by Kyra Delaney on 3/7/22.
//

import SwiftUI

struct ItemSortSelectionView: View {
    @Binding var selectedSortItem: ItemSort
    let sorts: [ItemSort]
    
    var body: some View {
        Menu {
            Picker("Sort By", selection: $selectedSortItem) {
                ForEach(sorts, id: \.self) { sort in
                    Text("\(sort.name)")
                }
            }
        } label: {
            Label("Sort", systemImage: "line.horizontal.3.decrease.circle")
        }
        .pickerStyle(.inline)
    }
}

struct ItemSortSelectionView_Previews: PreviewProvider {
    @State static var sort = ItemSort.default
      static var previews: some View {
          ItemSortSelectionView(
          selectedSortItem: $sort,
          sorts: ItemSort.sorts)
      }
}

