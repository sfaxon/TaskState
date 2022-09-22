//
//  ContentViewWithProgress.swift
//  TaskState
//
//  Created by Seth Faxon on 9/22/22.
//

import SwiftUI

struct ContentViewWithProgress: View {
    @State private var isProcessingShare = false
    @State private var isSharing = false
    @State private var shareItem: ShareItem?

    var body: some View {
        VStack {
            Text("Content View With Progress")
            progressView
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
        isProcessingShare = true
        shareItem = try? await ShareItem.build()
        isProcessingShare = false
        isSharing = true
    }

    @ViewBuilder
    private var shareView: some View {
        if let share = shareItem {
            SheetView(shareItem: share)
        }
    }

    var progressView: some View {
        Group {
            if isProcessingShare {
                ProgressView()
            }
        }
    }
}

struct ContentViewWithProgress_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewWithProgress()
    }
}
