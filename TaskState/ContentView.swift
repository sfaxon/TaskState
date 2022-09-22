//
//  ContentView.swift
//  TaskState
//
//  Created by Seth Faxon on 9/22/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isSharing = false
    @State private var shareItem: ShareItem?

    var body: some View {
        VStack {
            Button {
                Task {
                    try? await doTask()
                }
            } label: {
                Text("show sheet")
            }
            .sheet(isPresented: $isSharing, content: { shareView })
        }
        .padding()
    }

    func doTask() async throws {
        shareItem = try? await ShareItem.build()
        isSharing = true
    }

    @ViewBuilder
    private var shareView: some View {
        if let share = shareItem {
            SheetView(shareItem: share)
        }
    }
}

struct SheetView: View {
    let shareItem: ShareItem

    var body: some View {
        VStack {
            Text("it worked!")
            Text("shareItem.value is \(shareItem.value)")
        }
    }
}

class ShareItem {
    let value = 1 // no real meaning
    init() {}

    static func build() async throws -> ShareItem {
        try await Task.sleep(nanoseconds: 1000)
        return ShareItem()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
