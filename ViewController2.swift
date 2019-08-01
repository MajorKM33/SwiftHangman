//
//  ViewController2.swift
//  hangman
//
//  Created by Michał Ciborowski on 27.09.2016.
//  Copyright © 2016 Michał Ciborowski. All rights reserved.
//

import UIKit

extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

class ViewController2: UIViewController, UITextFieldDelegate {
    
    var mode : String = ""
    
    var usedLetters = [""]
    var newArray = true;
    
    var opel = ["vectra","corsa","insignia"]
    var jasne = [""]
    var chosenWordArray = [String()]
    var chosenWord : String = ""
    var checkChar : Character = " "
    var emptyWord = String()
    var wordLetters = [""]
    var toGuess : Int = -1;
    var chances : Int = 0;
    var w : Int = 0;
    var image : UIImage = UIImage()
    var hangImg = ["img/h1.png","img/h2.png","img/h3.png","img/h4.png","img/h5.png","img/h6.png","img/h7.png",]
    
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var keyWordShow: UILabel!
    
    var bgImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtValue.delegate = self
        
        let sz = UIScreen.main.bounds
        w = Int(sz.width)
        
        //print(mode)
        txtValue.becomeFirstResponder()
        // Do any additional setup after loading the view.
        
        image = UIImage(named: "img/h1.png")!
        bgImage = UIImageView(image: image)
        bgImage!.frame = CGRect(x: 0, y: 0, width: w, height: w)
        self.view.addSubview(bgImage!)
        
        chosenWordArray = opel
        chosenWordArray.shuffle()
        chosenWord = chosenWordArray[0]
        toGuess = chosenWord.characters.count
        
        for index in 1...chosenWord.characters.count{
            emptyWord += "_ "
        }
        
        keyWordShow.text = emptyWord
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /*if ((txtValue.text?.characters.count)! > 0) {
            txtValue.deleteBackward()
        }
        print(usedLetters.count)
        if( usedLetters.count > 1 ){
        for index in 0...usedLetters.count-1{
            print((txtValue.text!) + " " + usedLetters[index])
            if (Character(txtValue.text!) == Character(usedLetters[index])) {
                txtValue.deleteBackward()
            }
        }
        }*/
        
        if(usedLetters.count > 0){
            textField.text = ""
            for i in 0...(usedLetters.count - 1){
                print(usedLetters, i, usedLetters[i], string)
                
                if(string == usedLetters[i]){
                    
                    return false
                }
            }
        }
        
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //print("WORKS!")
        
        if( textField.text == ""){
            return false;
        }
        
        if(newArray){
            usedLetters[0] = txtValue.text!
            newArray = false
            //print(usedLetters[0])
            //print(newArray)
        }
        else{
            usedLetters.append(txtValue.text!)
            //print(usedLetters[0])
        }
        
        var index : Int = 0
        var guessed : Bool = false
        var tmp : String = keyWordShow.text!
        checkChar = Character(txtValue.text!)
        
        for character in chosenWord.characters {
            //print(character)
            //print(checkChar)
            
            if( character == checkChar ){
                print("CHECKED!")
                var pos : Int = index*2
                
                var chars = Array(tmp.characters)
                chars[pos] = checkChar
                tmp = String(chars)
                guessed = true
                toGuess -= 1
                keyWordShow.text = tmp
            }
            if( character != Character(txtValue.text!) ){
                //print("FALSE!")
            }
            
            index+=1
        }
        
        if( guessed == false ){
            chances += 1
            
            image = UIImage(named: hangImg[chances])!
            bgImage = UIImageView(image: image)
            bgImage!.frame = CGRect(x: 0, y: 0, width: w, height: w)
            self.view.addSubview(bgImage!)
        }
        
        if( toGuess == 0 ){
            print("LIVE")
            
            let alert = UIAlertController(title: "Wygrałeś!",
                                          message: "",
                                          preferredStyle: .alert)
            let dismissHandler = {
                (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(UIAlertAction(title: "Jupi",
                                          style: .cancel,
                                          handler: dismissHandler))
            present(alert, animated: true, completion: nil)
            
            let vc : UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "vc"))!
            self.show(vc, sender: vc)
        }
        if( chances == 6 ){
            print("DEAD")
            
            let alert = UIAlertController(title: "Przegrałeś!",
                                          message: "",
                                          preferredStyle: .alert)
            let dismissHandler = {
                (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(UIAlertAction(title: "O nie!",
                                          style: .cancel,
                                          handler: dismissHandler))
            present(alert, animated: true, completion: nil)
            
            let vc : UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "vc"))!
            self.show(vc, sender: vc)
        }
        
        return true;
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
