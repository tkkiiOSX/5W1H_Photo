//
//  ImagePicker.swift
//  5W1H_Photo
//
//  Created by Xcode2021 on 2021/08/09.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?
    @Binding var isPicking: Bool
    @Binding var importDate: Date

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        //picker.sourceType = .photoLibrary
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker(image: .constant(nil), isPicking: .constant(true), importDate: .constant(Date()))
    }
}
