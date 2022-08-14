//
//  PhotoPicker.swift
//  Happy Me Meditation
//
//  Created by Bogdan Zykov on 11.08.2022.
//


import SwiftUI
import PhotosUI


//struct PhotoPicker: UIViewControllerRepresentable{
//
//    @Binding var selectedImage: UIImageData?
//    var sourseType: UIImagePickerController.SourceType = .photoLibrary
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.allowsEditing = true
//        picker.sourceType = sourseType
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(photoPicker: self)
//    }
//
//    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
//        var photoPicker: PhotoPicker
//        init(photoPicker: PhotoPicker){
//            self.photoPicker = photoPicker
//        }
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let image = info[.editedImage] as? UIImage{
//                var imagePath = UUID().uuidString
//                if let url = info[.imageURL] as? URL{
//                    imagePath = url.lastPathComponent
//                }
//                photoPicker.selectedImage = UIImageData(fileName: imagePath, image: image)
//            }else{
//               print("no image")
//            }
//            picker.dismiss(animated: true)
//        }
//    }
//}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImageData?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        config.preferredAssetRepresentationMode = .current
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    let uIImageData = UIImageData(fileName: provider.suggestedName ?? "no name", image: image as? UIImage)
                    DispatchQueue.main.async {
                        self.parent.image = uIImageData
                    }
                }
            }
        }
    }
}


struct UIImageData{
    var id: String = UUID().uuidString
    var fileName: String
    var image: UIImage?
}

