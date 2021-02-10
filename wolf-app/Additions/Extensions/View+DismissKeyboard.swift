//
//  View+DismissKeyboard.swift
//  wolf-app
//
//  Created by Maxence Mottard on 09/02/2021.
//

import UIKit
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
