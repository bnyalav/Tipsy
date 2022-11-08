//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculaterViewController: UIViewController {
    
    var tip = 0.10 //çarpılacak oran
    var splitNumber = 2//kişi sayısı
    var billTotal = 0.0//toplam hesap
    var finalResult = "0.0" //bölünen bahşiş string olması için tırnak içine aldık
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var billTextFieled: UITextField!

    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextFieled.text!//bill sabite textten gelen veriye eşittir
        if bill != ""{ //text eğer boş değilse
            billTotal = Double(bill)!
            let result = billTotal * (1 + tip) / Double(splitNumber)
            finalResult = String(format: "%.2f", result)
            self.performSegue(withIdentifier: "goToResult", sender: self)//yeni sayfaya gitme
        } else{
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//yeni sayfaya değer atamalarını yapma
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = splitNumber
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value) //labela yazılcak değer sender valueden gelen değerdir
        splitNumber = Int(sender.value) //splitnumber seçilen değerdir
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextFieled.endEditing(true)
        zeroPctButton.isSelected = false//bütün butonların seçililiğini kaldır
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true //basılan butonu seçili yap
        
        let buttonTitle = sender.currentTitle! //seçilen butonun mevcut başlığını al
        
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast()) //yüzde işaretini kaldır ve stringe çevir
        
        let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)! //Stringi double çevir
        
        tip = buttonTitleAsANumber / 100
        
    }
}

