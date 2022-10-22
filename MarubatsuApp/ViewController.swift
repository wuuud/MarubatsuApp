//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by H M on 2022/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func tappedNoButton(_ sender: UIButton) {
        checkAnswer(yourAnswer: false)
    }
    @IBAction func tappedYesButton(_ sender: UIButton) {
        checkAnswer(yourAnswer: true)
    }
    @IBOutlet weak var questionLabel: UILabel!
    // 変数1 表示中の問題番号を格納
    //var currentQuestionNum: Int = 0
    //型推論できるので下記の書き方でもOK
    var currentQuestionNum = 0
    //変数2 問題のリストを辞書の配列  配列[]の中に連想配列[]
    let questions: [[String: Any]] = [
        //        配列の中にキーとバリュー
        [
            "question": "iPhoneアプリを開発する統合環境はZcodeである",
            "answer": false
        ],
        [
            "question": "Xcode画面の右側にはユーティリティーズがある",
            "answer": true
        ],
        [
            "question": "UILabelは文字列を表示する際に利用する",
            "answer": true
        ]
    ]
    
    //問題表示用の関数を作成
    func showQuestion() {
        // 1つだけ取得してくる
        //例) var currentQuestionNum = 0 なら [
        //        "qusetion": "iPhoneアプリを開発する統合環境はZcodeである",
        //        "answer": false
        //    ]がquestionに入る
        let question = questions[currentQuestionNum]
        
        //if letオプショナルバインディング でnulじゃないか確認後
        if let que = question["question"] as? String {
            questionLabel.text = que
        }
    }
    
    //問題表示用の関数を呼び出し
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showQuestion()
    }
    
    //回答したときの関数 回答をチェックする関数
    // 正解なら次の問題を表示します
    //yourAnswer: Boolでtrueかfalse 関数内で正解のボタンが押されたか判定するために引数を定義
    //引数といい、関数が呼び出された際に呼び出し元から渡してもらう値、
    //つまり関数checkAnswerが呼び出されたときにyourAnswer: true or falseを入れてね
    func checkAnswer(yourAnswer: Bool) {
        //今表示されている問題
        let question = questions[currentQuestionNum]
        //if letオプショナルバインディングで確認後 上記で設定した今表示されているquestion
        if let ans = question["answer"] as? Bool {
            // 自分の回答 yourAnswer: Bool == 配列の中のtrue or false
            if yourAnswer == ans {
                // 正解  currentQuestionNumを1足して次の問題に進む
                currentQuestionNum += 1
                showAlert(message: "正解！")
            } else {
                // 不正解
                showAlert(message: "不正解")
            }
        } else {
            print("答えが入ってません")
            //これで終わり
            return
        }
        //エラー解消fatal error: Index out of range
        //currentQuestionNumの値が問題数以上だったら最初の問題に戻す
                if currentQuestionNum >= questions.count {
                    currentQuestionNum = 0
                }
        // 問題を表示    正解であれば次の問題が、不正解であれば同じ問題が再表示
        showQuestion()
    }
    // 正解か不正解かアラートを表示する関数   関数・決まり文句→表示のためにfunc checkAnswerに追加showAlert(message: "正解！")
    func showAlert(message: String) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
            alert.addAction(close)
            present(alert, animated: true, completion: nil)
        }
}
