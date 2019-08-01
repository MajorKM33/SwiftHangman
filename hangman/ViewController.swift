//
//  ViewController.swift
//  hangman
//
//  Created by Michał Ciborowski on 27.09.2016.
//  Copyright © 2016 Michał Ciborowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var pv: UIPickerView!
    var t = ["Kolory","Pojazdy","Jedzenie"]
    var lastSelected : Int = 0
    var kolory = ["Ciemne","Jasne"]
    var pojazdy = ["Opel","Lamborghini","Ferrari","Bugatti"]
    var jedzenie = ["Owoce","Warzywa","Włoskie"]
    var selTable = [""]
    var temp1 = [""]
    var temp2 = [""]
    var kat = [""]
    var podkat = [[]]
    var tmp = [""]
    
    var selectedCategory = ""
    var sel1 = 0
    var sel2 = 0
    
    struct cat {
        var name = String();
        var sub = [String]();
    }
    
    var array = [cat]()
    
    var category : Int = 0
    var topic : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pv.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlString = "http://mkm33.c0.pl/hangman.php?"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSArray
                    let len : Int = parsedData.count
                    
                    var tmpStruct = cat()
                    
                    var currentConditions = parsedData[0] as! NSArray
                    var tmpKat : String = currentConditions[0] as! String
                    var tmpSub : String = currentConditions[1] as! String
                    var tmpSubArray = [String()]
                    tmpSubArray.removeAll()
                    tmpSubArray.append(tmpSub)
                    
                    if( len == 1 ){
                        tmpStruct = cat(name:tmpKat,sub:tmpSubArray)
                        self.array.append(tmpStruct)
                        tmpSubArray.removeAll()
                    }
                    
                    if( len > 1 ){
                    for i in 1...len-1{
                        currentConditions = parsedData[i] as! NSArray
                        //print(currentConditions[0])
                        //print(currentConditions[1])
                        
                        if( currentConditions[0] as! String == tmpKat ){
                            tmpSubArray.append(currentConditions[1] as! String)
                        }
                        if( currentConditions[0] as! String != tmpKat ){
                            tmpStruct = cat(name:tmpKat,sub:tmpSubArray)
                            self.array.append(tmpStruct)
                            
                            tmpKat = currentConditions[0] as! String
                            tmpSub = currentConditions[1] as! String
                            tmpSubArray = [String()]
                            tmpSubArray.append(tmpSub)
                        }
                        
                        }
                        
                        tmpStruct = cat(name:tmpKat,sub:tmpSubArray)
                        self.array.append(tmpStruct)
                    }
                    
                    print(self.array[0].name)
                    print(self.array[0].sub)
                    
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
        }).resume()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView ) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        //return t.count
        /*
        var row = pickerView.selectedRow(inComponent: 0)
        
        if component == 0 {
            return t.count
        }
            
        else {

            if(pickerView.selectedRow(inComponent: 0) == 0 ){
                selTable = kolory
            }
            if(pickerView.selectedRow(inComponent: 0) == 1 ){
                selTable = pojazdy
            }
            if(pickerView.selectedRow(inComponent: 0) == 2 ){
                selTable = jedzenie
            }
            return selTable.count
        }
         */
        
        if(component == 0){
            return array.count
        }
        else{
            return array[pickerView.selectedRow(inComponent: 0)].sub.count
        }
 
        /*
        if(component == 1){
            return array[pickerView.selectedRow(inComponent: 0)].sub.count
        }else{
            return array.count
        }*/
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return t[row]
        /*
        if component == 0 {
            return String(t[row])
        } else {
            return String(selTable[row])
        }
 */
        if(component == 1){
            selectedCategory = array[pickerView.selectedRow(inComponent: 0)].sub[row]
            
            return array[pickerView.selectedRow(inComponent: 0)].sub[row]
        }else{
            
            return array[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        sel1 = pickerView.selectedRow(inComponent: 0)
        sel2 = pickerView.selectedRow(inComponent: 1)
        print(sel1)
        print(sel2)
        print(array[sel1].sub[sel2])
        pickerView.reloadAllComponents()
        if(component == 0){
            pickerView.selectRow(0, inComponent: 1, animated: true)
        }    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cel = segue.destination as! ViewController2
        var ident : String = ""
        ident = segue.identifier!
        //cel.mode = sel
    }
    
}



/*
 
 
 
 var licznik : Int = 0;
 
 while(licznik != -1){
 
 var temptable = parsedData[licznik] as! NSArray
 self.temp1.append(temptable[0] as! String)
 self.temp2.append(temptable[1] as! String)
 licznik += 1
 if( licznik>len ){
 licznik = -1
 }
 }
 
 licznik = 1
 self.kat.append(self.temp1[0])
 self.tmp[0] = self.temp2[0]
 while(licznik != -1){
 
 if( self.temp1[licznik] == self.temp1[licznik-1]){
 self.tmp.append(self.temp2[licznik])
 }
 if( self.temp1[licznik] != self.temp1[licznik-1]){
 self.kat.append(self.temp1[licznik])
 self.podkat.append(self.tmp)
 self.tmp = [""]
 self.tmp[0] = self.temp2[licznik]
 //self.podkat.append(self.temp2[licznik])
 }
 
 licznik+=1
 if( licznik>len ){
 self.podkat.append(self.tmp)
 licznik = -1
 }
 }
 
 
*/

/*
 
 let vc : UIViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("vc"))!
 self.showViewController(vc, sender: vc)
 
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 let cel = segue.destinationViewController as! ViewController2
 var ident : String = ""
 ident = segue.identifier!
 if(ident == "easy"){
 cel.difficulty = 1
 }
 if(ident == "hard"){
 cel.difficulty = 2
 }
 
 }
 
 func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
 
 return 2
 
 }
 
 func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
 //row = [repeatPickerView selectedRowInComponent:0];
 var row = pickerView.selectedRowInComponent(0)
 println("this is the pickerView\(row)")
 
 if component == 0 {
 return minutes.count
 }
 
 else {
 return seconds.count
 }
 
 }
 
 func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
 
 if component == 0 {
 return String(minutes[row])
 } else {
 
 return String(seconds[row])
 }
 }
 
 */
