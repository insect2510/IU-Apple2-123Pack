
//
//  FormToolbar.swift
//  123Pack
//
//  Created by Oliver Hartmann on 16.11.26.
//

import Foundation
import SwiftUI

struct ToolbarSave: ToolbarContent {

    let cancelAction: () -> Void
    let saveAction: () -> Void

    var saveDisabled: Bool = false

    var body: some ToolbarContent {

        ToolbarItem(placement: .cancellationAction) {

            Button {
                cancelAction()
            } label: {
                Label(
                    "Cancel",
                    systemImage: NavIcons.cancel.rawValue
                )
            }
        }

        ToolbarItem(placement: .confirmationAction) {

            Button {
                saveAction()
            } label: {
                Label(
                    "Save",
                    systemImage: NavIcons.save.rawValue
                )
            }
            .disabled(saveDisabled)
        }
    }
}
