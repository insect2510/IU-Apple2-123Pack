
import Foundation
import SwiftUI

struct ToolbarDetails: ToolbarContent {

    let dismissAction: () -> Void
    var editDestination: AnyView? = nil

    var body: some ToolbarContent {

        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                dismissAction()
            } label: {
                Label("Back", systemImage: NavIcons.back.rawValue)
            }
        }

        if let editDestination {

            ToolbarItem(placement: .confirmationAction) {
                NavigationLink {
                    editDestination
                } label: {
                    Text("Edit")
                }
            }
        }
    }
}
