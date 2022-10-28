//
//  ViewController.swift
//  MarubatsuApp
//
//  Created by H M on 2022/10/22.
//

import UIKit

class ViewController: UIViewController {
    //1.初期設定
    //①表示中の問題番号を格納
    //var currentQuestionNum: Int = 0 型推論できるので下記の書き方でもOK
    var currentQuestionNum = 0
    //②問題のリスト配列  配列[]の中に連想配列[]
    var questions: [[String: Any]] = []
    var userDefaults = UserDefaults.standard
    //問題ない場合にボタン操作不能
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    //2.紐付け
    @IBAction func tappedNoButton(_ sender: UIButton) {
        checkAnswer(yourAnswer: false)
    }
    @IBAction func tappedYesButton(_ sender: UIButton) {
        if questions.isEmpty == false {
            checkAnswer(yourAnswer: true)
        }
    }
    
    func notenabledButton() {
        if questions.isEmpty {
            noButton.isEnabled = false
            yesButton.isEnabled = false
        } else {
            noButton.isEnabled = true
            yesButton.isEnabled = true
        }
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    
    //3.override
    //問題表示用の関数を呼び出し
    override func viewDidLoad() {
        super.viewDidLoad()
        //A.UserDefaultsからすでに入力されている質問と答えをquestionsに読み込む
        if userDefaults.object(forKey: "questions") != nil{
            questions = userDefaults.object(forKey: "questions") as! [[String: Any]]
        }
    }
    //同じ処理を何度も繰り返し行えるように
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //テキストフィールドに最初からフォーカスが表示される
        questionLabel.becomeFirstResponder()
        //UserDefaultsからすでに入力されている質問と答えをquestionsに読み込む
        if userDefaults.object(forKey: "questions") != nil{
            questions = userDefaults.object(forKey: "questions") as! [[String: Any]]
        }
        //ページを更新 tableView.reloadData()は使えない。
        showQuestion()
        notenabledButton()
    }
    
    //4.独自の関数
    //4−1.Aciton
    //4-2.func
    //①問題表示用
    func showQuestion() {
        // 1つだけ取得してくる
        //例) var currentQuestionNum = 0 なら [
        //        "qusetion": "iPhoneアプリを開発する統合環境はZcodeである",
        //        "answer": false
        //    ]がquestionに入る
        if questions.isEmpty {
            questionLabel.text = "問題がありません。新しい問題を作成してください。"
        } else {
            let question = questions[currentQuestionNum]
            //if letオプショナルバインディング でnulじゃないか確認後
            if let que = question["question"] as? String {
                questionLabel.text = que
            }
        }
    }
    //②回答時 回答をチェックする関数
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
                showAlert(message: "ざんねん・・不正解")
            }
            //if let ans = question["answer"] as? Boolのelse {
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
        //エラーDictionaryの中身がなければhttps://qiita.com/Saayaman/items/e82a09f93bb91409e446
        // 問題を表示    正解であれば次の問題が、不正解であれば同じ問題が再表示
        showQuestion()
    }
    //③アラート 正解か不正解かアラート 決まり文句checkAnswerに追加showAlert(message: "正解！")
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
}

