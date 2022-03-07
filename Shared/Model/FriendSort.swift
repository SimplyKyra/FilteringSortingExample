
import Foundation

struct PlaceSort: Hashable, Identifiable {
    
  let id: Int
  let name: String
  let descriptors: [SortDescriptor<Friend>]
  let section: KeyPath<Friend, String>

  static let sorts: [PlaceSort] = [
    PlaceSort(
      id: 0,
      name: "Meeting Place | Ascending",
      descriptors: [
        SortDescriptor(\Places.name, order: .forward),
        SortDescriptor(\Places.details, order: .forward)
      ],
      section: \Places.name),
    FriendSort(
      id: 1,
      name: "Meeting Place | Descending",
      descriptors: [
        SortDescriptor(\Friend.meetingPlace, order: .reverse),
        SortDescriptor(\Friend.name, order: .forward)
      ],
      section: \Friend.meetingPlace),
    FriendSort(
      id: 2,
      name: "Meeting Date | Ascending",
      descriptors: [
        SortDescriptor(\Friend.meetingDate, order: .forward),
        SortDescriptor(\Friend.name, order: .forward)
      ],
      section: \Friend.meetingDay),
    FriendSort(
      id: 3,
      name: "Meeting Date | Descending",
      descriptors: [
        SortDescriptor(\Friend.meetingDate, order: .reverse),
        SortDescriptor(\Friend.name, order: .forward)
      ],
      section: \Friend.meetingDayDescending)
  ]

  // 4
  static var `default`: FriendSort { sorts[0] }
}
