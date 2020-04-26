//
//  ViewController.swift
//  Swift5MapAndProject1
//
//  Created by ryota on 2020/04/26.
//  Copyright © 2020 Honda Ryota. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate,UIGestureRecognizerDelegate ,SearchLocationDelegate{

    //取得した住所を格納
    var addressString = ""
    
    //長押しボタンのオブジェクト
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    
    //マップビューのオブジェクト
    @IBOutlet weak var mapView: MKMapView!
    
    //アドレスラベルの宣言
    @IBOutlet weak var addressLabel: UILabel!
    
    //設定ボタンの宣言
    @IBOutlet weak var settingButton: UIButton!
    
    var locManager:CLLocationManager!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定ボタンのバックカラーを白に設定
        settingButton.backgroundColor = .white
        //設定ボタンの角を丸くする
        settingButton.layer.cornerRadius = 20.0

    }


    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        
         //senderを利用すると、状態がわかる
         //タップ開始時の処理
         if sender.state == .began{
             
             
             
         //タップ終了時
         }else if sender.state == .ended{
             
             //タッチした位置を計測する
             let tapPoint = sender.location(in: view)
             
             //タッチした位置から緯度と軽度を計算する
             let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
             
             let lat = center.latitude
             let log = center.longitude
             
             //緯度と軽度から住所を取得する
             convert(lat: lat, log: log)
             
         }
        
        
        
    }
    

    
    // CLLocationDegreesはクラス
    func convert(lat:CLLocationDegrees,log:CLLocationDegrees) {
        
        let geocoder = CLGeocoder()
        
        let location = CLLocation(latitude: lat, longitude: log)
        
        //クロージャー（カッコ内に値が入ったら発動される）
        //クロージャーの中はselfがいる
        geocoder.reverseGeocodeLocation(location) { (placeMark, error) in
            
            //　if placeMark != nil { } と同じ意味(オプショナルバイディング)
            // 代入しながらnilを確認できる
            if let placeMark = placeMark{
                
                //placeMarkの初めの値があれば通過
                if let pm = placeMark.first{
                    
                    //placeMarkは市や県の名前を取得できる
                    if pm.administrativeArea != nil || pm.locality != nil {
                        
                        self.addressString = pm.name! + pm.administrativeArea! + pm.locality!
                    
                    //県も市もない場合(は南極、北極など)
                    }else{
                        
                        self.addressString = pm.name!
                        
                    }
                   
                    // 住所ラベル　　にアドレスを表示
                    self.addressLabel.text = self.addressString
                    
                }
                
            }
            
        }
        
    }
    
    
    @IBAction func goToSearchVc(_ sender: Any) {
        
        //画面遷移
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    //遷移先の変数に値を渡す処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "next"{
            
            //デリゲートの引き受け
            let nextVC = segue.destination as! nextViewController
            nextVC.delegate = self
                    
        }
        
    }
    
    //引き受けたデリゲートの内容(領域の設定が必要)
    func searchLocation(idoValue: String, keidoValue: String) {
        
        if idoValue.isEmpty != true && keidoValue.isEmpty != true{
            
            //緯度の代入
            let idoSring =  idoValue
            
            //経度の代入
            let keidoString =  keidoValue
            
            //緯度、経度コーディネート
            let coordinate = CLLocationCoordinate2DMake(Double(idoSring)!, Double(keidoString)!)
            
            //表示する範囲を指定
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            
            //領域を指定
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            //領域をmapviewに指定
            mapView.setRegion(region, animated: true)
            
            //緯度から住所に変換
            convert(lat: Double(idoSring)!, log: Double(keidoString)!)
            
            //ラベルに表示(addressStringはstacic変数)
            addressLabel.text = addressString
            
            
        }else{
            
            //エラー処理
            addressLabel.text = "表示できません"
            
        }
        
        
    }
    
    
    
}

