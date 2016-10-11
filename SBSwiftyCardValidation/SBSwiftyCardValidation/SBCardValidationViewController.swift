//
//  SBCardValidationViewController.swift
//  SBCardValidate
//
//  Created by SANKARLAL on 10/10/16.
//  Copyright © 2016 SANKARLAL. All rights reserved.
//

import UIKit

class SBCardValidationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var cardNumberTextFld : UITextField!
    @IBOutlet var cardTypeImageView : UIImageView!
    @IBOutlet var validCardLable : UILabel!
    @IBOutlet var cardTypeNameLabel : UILabel!

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "SB Swifty Card Validation"
        cardNumberTextFld.delegate = self
        
        validCardLable.text = ""
        cardTypeNameLabel.text = ""

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cardNumberTextFld.becomeFirstResponder()
    }
    
    //MARK: Perform Clear Button
    @IBAction func performClearButton() {
    
        cardNumberTextFld.text = ""
        cardTypeImageView.image = nil
        validCardLable.text = ""
        cardTypeNameLabel.text = ""


    }
    
    //MARK: TextFiedl Delegate Function
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == cardNumberTextFld {
            
            let trimmedText = (textField.text! as NSString).replacingCharacters(in: range, with:string)
            
            let validateCard = SBCardValidateModel.validateCard(cardNumber: trimmedText as NSString)
            print("isValideCard", validateCard.isValidCard)
            print("Valid Card Name Is", validateCard.cardTypeName)

            if validateCard.isValidCard == true {
                cardTypeImageView.image = UIImage(named: validateCard.cardTypeName as String)
                validCardLable.text = "Card No is Valid"

            } else {
                cardTypeImageView.image = nil
                validCardLable.text = "Card No is Not Valid"

            }
            
            cardTypeNameLabel.text = validateCard.cardTypeName as String

            if trimmedText == "" {
                performClearButton()
            }
      }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
