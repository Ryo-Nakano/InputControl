//
//  ViewController.swift
//  InputControl
//
//  Created by 仲野 亮平 on 2019/06/26.
//  Copyright © 2019 仲野 亮平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var infoText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    func Check(str: String) -> Bool {
        var isPermitted:Bool = false
        // 文字列を表現するUInt32
        for c in str.unicodeScalars {
            if (c.value >= 0x3041 && c.value <= 0x3096) || //ひらがな
                (c.value >= 0x30A1 && c.value <= 0x30F6) || //カタカナ
                (c.value >= 0x2E80 && c.value <= 0x2FDF) || (c.value >= 0x3400 && c.value <= 0x4DBF) || (c.value >= 0x4E00 && c.value <= 0x9FFF) || (c.value >= 0xF900 && c.value <= 0xFAFF) || (c.value >= 0x20000 && c.value <= 0x2FFFF) || //漢字
                c.value == 0x0020 || c.value == 0xFF5A || c.value == 0x3005 || c.value == 0x3007 || c.value == 0x303B //特定の文字
            {
                // ひらがな・カタカナ・空白の場合
                isPermitted = true
            } else {
                // それ以外の場合、一文字でも対象以外の文字があった場合、抜けるようにした。
                isPermitted = false
                break
            }
        }
        return isPermitted
    }
    
    @IBAction func CheckButton(){
        guard let input: String = textField.text else {return}
        if input == "" {return}
        
        infoText.textColor = UIColor.blue
        infoText.text = "入力された内容に問題はありません"
        if(!Check(str: input)){ //条件に合わない時
            infoText.textColor = UIColor.red
            infoText.text = "※ 条件に合わない文字が含まれています"
        }
        
        //2.0秒後に処理
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            self.infoText.text = ""
        }
    }

}

