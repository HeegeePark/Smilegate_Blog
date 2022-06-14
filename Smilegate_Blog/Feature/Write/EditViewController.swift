//
//  EditViewController.swift
//  Smilegate_Blog
//
//  Created by 박희지 on 2021/11/04.
//

import UIKit
import MobileCoreServices
import ImageIO

class EditViewController: UIViewController, UINavigationControllerDelegate {
@IBOutlet weak var uploadButton: UIBarButtonItem!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentsField: UITextField!
    @IBOutlet weak var cameraButton: UIButton!
    let viewModel = WriteViewModel()
    let user = User.shared
    var image: UIImage? = nil
    // segue 수행 직전 준비하는 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(3)
        // posting 업뎃하고, PostViewController에 데이터 넘겨주기
        if segue.identifier == "showPost" {
            switch viewModel.editMode {
            case .create:
                let title = titleField.text ?? ""
                let contents = contentsField.text ?? ""
                let timestamp: Double = Date().timeIntervalSince1970.rounded()
                let emptyComment = Comment(id: "", userName: user.name, content: "", timestamp: 0)
                let newPosting = Posting(identifier: String(Posting.identifier), userName: user.name, title: title, contents: contents, timestamp: timestamp, comments: [emptyComment], likes: "0")
                viewModel.update(model: newPosting)
                if self.image != nil {
                    viewModel.updateImage(image: self.image!)
                } else {
                    viewModel.updatePosting()
                    let postVC = segue.destination as? PostViewController
                    let posting = self.viewModel.posting
                    postVC?.viewModel.update(model: posting, prev: .edit)
                    return
                }
            case .modify:
                viewModel.posting?.title = titleField.text ?? ""
                viewModel.posting?.contents = contentsField.text ?? ""
                if self.image != nil {
                    viewModel.updateImage(image: self.image!)
                } else {
                    viewModel.updatePosting()
                    let postVC = segue.destination as? PostViewController
                    let posting = self.viewModel.posting
                    postVC?.viewModel.update(model: posting, prev: .edit)
                    return
                }
            }
            viewModel.beReadyImageHandler = {
                let postVC = segue.destination as? PostViewController
                let posting = self.viewModel.posting
                postVC?.viewModel.update(model: posting, prev: .edit)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(mode: viewModel.editMode)
    }
    @IBAction func editingTitleStarted(_ sender: Any) {
        self.titleField.textColor = .textBlackColor
    }
    @IBAction func editingContentseStarted(_ sender: Any) {
        self.contentsField.textColor = .textBlackColor
    }
    
    func updateUI(mode: EditMode) {
        switch mode {
        case .create:
            titleField.clearsOnBeginEditing = true
            contentsField.clearsOnBeginEditing = true
        case .modify:
            if let postingInfo = viewModel.posting {
                titleField.clearsOnBeginEditing = false
                contentsField.clearsOnBeginEditing = false
                self.titleField.textColor = .textBlackColor
                self.contentsField.textColor = .textBlackColor
                titleField.text = postingInfo.title
                contentsField.text = postingInfo.contents
            }
        }
    }
}

// MARK: - Photo Actions
extension EditViewController {
    @IBAction func takePicture(_ sender: Any) {
        // Show options for the source picker only if the camera is available.
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }
            
        let photoSourcePicker = UIAlertController()
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .camera)
        }
        let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .photoLibrary)
        }
            
        photoSourcePicker.addAction(takePhoto)
        photoSourcePicker.addAction(choosePhoto)
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
        present(photoSourcePicker, animated: true)
    }
        
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
}

// MARK: - Handling Image Picker Selection
extension EditViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let newImage = image
//            self.cameraButton.setImage(newImage, for: .normal)
//            resizeCameraButton()
            self.image = newImage
        }
    }
    
    func resizeCameraButton() {
        self.cameraButton.translatesAutoresizingMaskIntoConstraints = false
        self.cameraButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        self.cameraButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.cameraButton.centerYAnchor.constraint(equalTo: self.titleField.centerYAnchor).isActive = true
    }
}
