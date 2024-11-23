//
//  DetailedViewController.swift
//  2210991507_test2
//
//  Created by student-2 on 23/11/24.
//

import UIKit
import SafariServices
import MessageUI

class DetailedViewController: UIViewController , UINavigationControllerDelegate,MFMailComposeViewControllerDelegate,UIImagePickerControllerDelegate{
    var meal:Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meal=meal{
            nameLabel.text=meal.name
            calories.text=String(meal.calories)
            prepTime.text=String(meal.preparationTime)
            Instructions.text=meal.instructions
            imageOutlet.image=UIImage(named: meal.image)
            
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var calories: UILabel!
    
    @IBOutlet weak var prepTime: UILabel!
    
    @IBOutlet weak var Instructions: UILabel!
    
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image=imageOutlet.image else {
            return
        }
        guard let name = meal?.name else{
            return
        }
        guard let calories = meal?.calories else{
            return
        }
        guard let prepTime = meal?.preparationTime else{
            return
        }
        guard let instructions = meal?.instructions else{
            return
        }
        let activityController=UIActivityViewController(activityItems: [image,name,calories,prepTime,instructions], applicationActivities: nil)
        
        present(activityController, animated: true, completion: nil)
        
    }
    
   
    @IBAction func emailButtonTapped(_ sender: Any) {
        
        guard MFMailComposeViewController.canSendMail() else {return}
        
        guard let name = meal?.name else{
            return
        }
        guard (meal?.calories) != nil else{
            return
        }
        guard (meal?.preparationTime) != nil else{
            return
        }
        guard (meal?.instructions) != nil else{
            return
        }
        
        let mailComposer=MFMailComposeViewController()
        mailComposer.delegate=self
        
        mailComposer.setSubject("Meal")
        mailComposer.setToRecipients(["dhruv4258@gmail.com"])
        mailComposer.setMessageBody("this is email for meal plan for \(name)", isHTML: false)
        present(mailComposer, animated: true, completion: nil)
    }
    
    
    @IBAction func cameraTapped(_ sender: UIButton) {
        
        let imagePicker=UIImagePickerController()
        imagePicker.delegate=self
        
        
        let alertContoller=UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction=UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertContoller.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let cameraAction=UIAlertAction(title: "Camera", style: .default, handler: { action in
                print("User chosen camera")
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertContoller.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction=UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                print("User chosen library")
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertContoller.addAction(photoLibraryAction)
        }
        
        present(alertContoller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage=info[.originalImage] as? UIImage else {return}
        imageOutlet.image=selectedImage
        dismiss(animated: true, completion: nil)
    }
    
}
