//
//  SBCardValidateModel.swift
//  SBCardValidate
//
//  Created by SANKARLAL on 10/10/16.
//  Copyright © 2016 SANKARLAL. All rights reserved.
//

import UIKit

class SBCardValidateModel: NSObject {

    class func validateCard(cardNumber : NSString) -> (isValidCard : Bool, cardTypeName : NSString) {
        
        var cardTypeStr : NSString = ""

        if cardNumber.length > 3 {
            
            let subStringIndexTwo : Int = Int(cardNumber.substring(to: 2))!
                
            switch  subStringIndexTwo {
            
            case 34, 37 :
            cardTypeStr = "Amex" // American Express
            break
                
            case 36:
                cardTypeStr = "DinersClub" // Diners Club
                break
                
            case 38:
                cardTypeStr = "CarteBlanche" // Carte Blanche
                break
                
            case 51 ... 55:
                cardTypeStr = "MasterCard" // Master Card
                break


            default:
                
                let subStringIndexFour : Int = Int(cardNumber.substring(to: 4))!
                
                switch subStringIndexFour {
                    
                case 2014, 2149:
                    cardTypeStr = "EnRoute" // EnRoute
                    break
                    
                case 2131, 1800:
                    cardTypeStr = "Jcb" // JCB
                    break
                    
                case 6011:
                    cardTypeStr = "Discover" // Discover
                    break
                    
                default:
                    
                    let subStringIndexTheree : Int = Int(cardNumber.substring(to: 3))!
                    
                    switch subStringIndexTheree {
                        
                    case  300 ... 305 :
                        cardTypeStr = "AmericanDinersClub" // American Diners Club
                        break
                        
                    default:
                        
                        let subStringIndexOne : Int = Int(cardNumber.substring(to: 1))!

                        switch  subStringIndexOne {
                            
                        case 3:
                            cardTypeStr = "Jcb" // JCB
                            break
                            
                        case 4:
                            cardTypeStr = "VisaCard" // Visa Card
                            break
                            
                        default:
                            cardTypeStr = "NoName"
                            break
                            
                        }
                        
                        break
                    }

                    break
                }

                break

            }
        }
        
        // End Check Card Type
        print("cardNumber", cardNumber.length)
        
        if cardNumber.length > 12 {
            
            let characters : NSMutableArray = NSMutableArray()
            
            for index in 0 ..< cardNumber.length {
                let ichar : NSString = NSString(format: "%c", cardNumber.character(at: index))
                characters.add(ichar)
            }
            
            let stringAsChars : NSMutableArray = NSMutableArray(array: characters)
            
            var isOdd : Bool = true
            var oddSum : Int = 0
            var evenSum : Int = 0
            let length : Int = Int(cardNumber.length - 1)
            
            for indexValue in (0 ... length).reversed() {
                
                let digit : Int = Int(stringAsChars.object(at: indexValue) as! String)!
                
                if isOdd {
                    oddSum += digit
                    
                } else {
                    evenSum += digit/5 + (2*digit) % 10

                }
                isOdd = !isOdd
            }
            
            return ((oddSum + evenSum) % 10 == 0, cardTypeStr)

        } else {
            return (false, cardTypeStr)

        }
    }
}
