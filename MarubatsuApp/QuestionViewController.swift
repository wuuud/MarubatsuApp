//
//  QuestionViewController.swift
//  MarubatsuApp
//
//  Created by H M on 2022/10/23.
//

import UIKit

class QuestionViewController: UIViewController {
    //1.初期値
    var questions: [[String: Any]] = []
    var userDefaults = UserDefaults.standard
    //2.紐付け
    //トップ画面に戻る
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    @IBOutlet weak var questionMakeText: UITextField!
    @IBAction func storeButton(_ sender: UIButton) {
        if questionMakeText.text != "" {
            //真偽値の初期値
            var boolAnswer: Bool
            //https://ios-docs.dev/uisegmentedcontrol/
            switch selectSegmentedControl.selectedSegmentIndex {
            case 0:
                boolAnswer = false
            case 1:
                boolAnswer = true
            default:
                boolAnswer = false
            }
            if userDefaults.object(forKey: "questions") != nil{
                questions = userDefaults.object(forKey: "questions") as! [[String: Any]]
            }
            questions.append(["question": questionMakeText.text!, "answer": boolAnswer])
            userDefaults.set(questions, forKey: "questions")
            showAlert(message:  "登録完了")
            questionMakeText.text = ""
            print(questions)
        } else {
            showAlert(message: "問題文を入力してください")
        }
    }
    @IBAction func allClearButton(_ sender: UIButton) {
        questions.removeAll()
        // 追加：削除した内容を保存
        userDefaults.set(questions, forKey: "questions")
        //tableView更新は不要 ページ再読み込みしない tableView.reloadData()
        showAlert(message: "問題を全て削除しました")
        print(questions)
    }
    //segmented https://qiita.com/rea_sna/items/7e472af2ce8d03831b55
    @IBOutlet weak var selectSegmentedControl: UISegmentedControl!
    @IBAction func tappedSegmentedControl(_ sender: UISegmentedControl) {
    }
    
    //3.自動
    override func viewDidLoad() {
        super.viewDidLoad()
        questionMakeText.placeholder = "問題を入力してください"
        //       UserDefaultsからすでに入力されている質問と答えをquestionsに読み込む
        if userDefaults.object(forKey: "questions") != nil{
            questions = userDefaults.object(forKey: "questions") as! [[String: Any]]
        }
    }
    //テキストフィールドに最初からフォーカスが表示される
    override func viewWillAppear(_ animated: Bool) {
        questionMakeText.becomeFirstResponder()
    }
    
    //4.関数
    //①アラート 決まり文句checkAnswerに追加showAlert(message: "正解！")
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
}
