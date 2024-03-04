//
//  CustomColorPicker.swift
//  TonOnTon
//
//  Created by mino on 2024/03/04.
//

import SwiftUI

struct CustomColorPicker: UIViewControllerRepresentable{
    @Binding var color: Color
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = false
        picker.selectedColor = UIColor(color)
        picker.delegate = context.coordinator
        picker.title = ""
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {
//        uiViewController.view.tintColor = (color.isDarkColor ? .white : .black)
        uiViewController.view.tintColor = .blue
    }
    
    class Coordinator: NSObject,UIColorPickerViewControllerDelegate{
        var parent: CustomColorPicker
        
        init(parent: CustomColorPicker) {
            self.parent = parent
        }
        
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            // Updating Color
            parent.color = Color(viewController.selectedColor)
        }
        
        func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
            parent.color = Color(color)
        }
    }
}
