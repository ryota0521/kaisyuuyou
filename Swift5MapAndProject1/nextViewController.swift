//
//  nextViewController.swift
//  Swift5MapAndProject1
//
//  Created by ryota on 2020/04/26.
//  Copyright © 2020 Honda Ryota. All rights reserved.
//

import UIKit

//規約を作る
protocol SearchLocationDelegate {
 
    //デリゲートの変数化（selfの設定に、デリゲートの呼び出しに使う）
    func searchLocation(idoValue:String,keidoValue:String)
}

class nextViewController: UIViewController {

    //デリゲートの変数化（selfの設定に、デリゲートの呼び出しに使う）
    var delegate:SearchLocationDelegate?
    
    //緯度テキストのオブジェクト
    @IBOutlet weak var idoTextField: UITextField!
    
    //経度テキストのオブジェクト
    @IBOutlet weak var keidoTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func okAction(_ sender: Any) {
        
        //入力された値を取得
        let idoValue = idoTextField.text!
        let keidoValue = keidoTextField.text!
        
        //テキストが空で無ければ戻る
        if idoTextField.text != nil && keidoTextField.text != nil {
            
            //デリゲートメソッドに値を入れる
            delegate?.searchLocation(idoValue:idoValue,keidoValue:keidoValue)
            
            //戻る遷移
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
    
    
    
    

}
