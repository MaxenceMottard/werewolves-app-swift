//
//  AlertTextField.swift
//  wolf-app
//
//  Created by Maxence Mottard on 11/02/2021.
//

import UIKit
import SwiftUI

struct AlertTextField: UIViewControllerRepresentable {
    @Binding var isPresented: Bool

    let title: String
    let description: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let actionHandler: (String) -> Void
    let cancelHandler: (() -> Void)?
    let formatText: ((String) -> String)?

    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertTextField>) -> some UIViewController {
        return UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<AlertTextField>) {
        if isPresented {
            let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)

            alert.addTextField { (textField:UITextField) in
                textField.placeholder = placeholder
                textField.keyboardType = keyboardType
                textField.delegate = context.coordinator
            }
            
            alert.addAction(UIAlertAction(title: L10n.Common.AlertTextField.cancel, style: .cancel) { _ in
                cancelHandler?()
            })

            alert.addAction(UIAlertAction(title: L10n.Common.AlertTextField.submit, style: .default) { _ in
                actionHandler(context.coordinator.textFieldText)
            })

            DispatchQueue.main.async {
                uiViewController.present(alert, animated: true) {
                    isPresented = false
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(formatString: formatText)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        let formatString: ((String) -> String)?
        var textFieldText: String = ""

        init(formatString: ((String) -> String)?) {
            self.formatString = formatString
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard var text = textField.text else { return true }

            text = NSString(string: text).replacingCharacters(in: range, with: string)
            text = formatString?(text) ?? text
            textFieldText = text
            textField.text = text
            
            return false
        }
    }
}
