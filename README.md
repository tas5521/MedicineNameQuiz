# 薬名暗記カード

## 1. 概要
薬名暗記カードは、薬の名前の暗記学習をサポートするアプリです。<br>
薬剤師さんは、調剤業務をするために、薬の商品名と一般名の対応関係を覚えます。（例：商品名は「ロキソニン」で一般名は「ロキソプロフェンナトリウム水和物」など）<br>
しかし、これまで薬の名前を学習するためのツールは無く、薬剤師さんが自分で薬名のリストや暗記カードを作成する必要がありました。<br>
そこで本プロジェクトでは、薬剤師さんの学習の負担を減らすため、薬の名前の暗記カードのアプリを作成しました。<br>

## 2. ダウンロードリンク
[![App_Store_Badge_JP](https://user-images.githubusercontent.com/68992872/204145956-f5cc0fa8-d4c9-4f2c-b1d4-3c3b1d2e2aba.png)](https://apps.apple.com/jp/app/%E8%96%AC%E5%90%8D%E6%9A%97%E8%A8%98%E3%82%AB%E3%83%BC%E3%83%89/id6502452243)

## 3. アプリの機能
### ① 学習
暗記カードを使って学習できます。<br>
まるボタンとばつボタンで、正解・不正解を記録できます。<br>
<img width="250" src="ScreenShots/Explanation_7.png"><br>

### ② 問題リスト
覚えたい薬名の問題リストを作成できます。<br>
薬局や病院によって扱っている薬は様々なので、ユーザー個別の問題リストを作成できるようにしました。<br>
<img width="250" src="ScreenShots/Explanation_8.png"><br>

### ③ 薬リスト
本アプリで扱うことのできる薬の商品名と一般名を確認できるようにするため、薬リストを作成しました。<br>
<img width="250" src="ScreenShots/Explanation_9.png"><br>

## 4. アプリの動作
### ① 学習
暗記カードの表面には問題が表示されています。カードをタップすると回転し、裏面の答えが表示されます。<br>
正解したら、⭕️ボタンを押し、不正解なら、❌ボタンを押します。これにより、結果が記録されます。<br>
最後に、学習結果を確認できます。<br>
<img width="250" src="ScreenShots/Explanation_3.gif"><br>

記録した学習結果を使い、わからない問題（正解できていない問題）だけを出題できるので、まだ覚えていない薬名だけに絞って効率よく復習できます。<br>
<img width="250" src="ScreenShots/Explanation_5.gif"><br>

### ② 問題リスト
問題リスト作成画面では、スイッチのONとOFFを切り替える操作で、追加・削除ができます。<br>
<img width="250" src="ScreenShots/Explanation_2.gif"><br>

学習結果は問題リストに記録されるので、知識の定着具合を後から確認することができます。<br>
学習結果は、商品名から一般名を答える方向（商 → 般）と一般名から商品名を答える方向（般 → 商）の両方が記録されます。<br>
<img width="250" src="ScreenShots/Explanation_4.gif"><br>

### ③ 薬リスト
薬は、内用薬・注射薬・外用薬に分類されており、薬リストの上部のタブで切り替えられます。<br>
薬は沢山あるので、検索できるようにしました。<br>
<img width="250" src="ScreenShots/Explanation_1.gif"><br>

## 5. 今後追加する予定の機能
- アプリを使うためのヒントを表示する機能
- 薬リストから選択した薬をWeb検索する機能
- 薬の名前の由来を表示する機能
- クイズ形式での知識の定着度のテスト機能
- 上記のテスト結果のランキング機能

## 6. MVVMの構成
本アプリのアーキテクチャにはMVVM（Model-View-ViewModel）を採用しました。

### View
|ファイル名|解説・概要|
|--|--|
|MainTabView|Tab切り替えを実装するメインのView|
|SearchBar|薬名や問題リストの検索バーの汎用的なView|
|NavigationBarBackground|ナビゲーションバーの背景を定義する構造体|
|TextFieldBackground|テキストフィールドの背景を定義する構造体|

学習画面
|ファイル名|解説・概要|
|--|--|
|IntroductionView|初回アプリ起動時に表示する導入画面のView|
|ModeSelectionView|学習に使う問題リストの選択や出題の設定を受け取る画面（学習モード選択画面）のView|
|StudyView|暗記カードを使った学習を提供する画面のView|
|ResultView|学習結果を表示する画面のView|
|AnswerButton|StudyViewで使用する正解ボタン・不正解ボタン・戻るボタンの元となる汎用的なView|
|BannerView|Google AdMobのバナー広告のView|

問題リスト画面
|ファイル名|解説・概要|
|--|--|
|PromptToCreateQuestionListView|ユーザーに問題リストの作成を促す画面のView|
|QuestionListView|ユーザーが作成した問題リストを表示する画面のView|
|QuestionsView|問題リスト内に保存された問題の一覧を表示する画面のView|
|CreateQuestionListView|問題リストを作成・編集する画面のView。ユーザーからの出題する薬名の選択を受け付ける。|
|MedicineSelectableList|問題リストに追加したい薬名を選択するためのToggleボタンの付いたリストのView|

薬リスト画面
|ファイル名|解説・概要|
|--|--|
|MedicineListView|薬名のリストを表示する画面のView|
|AddMedicineView|ユーザー独自の薬名をリストに追加する画面のView|
|TopTabView|上部に付けられるタブのView。薬の分類（内用薬、注射薬、外用薬）を切り替える。|

設定画面
|ファイル名|解説・概要|
|--|--|
|SettingsListView|設定の項目を列挙するリスト画面のView|
|HowToUseView|アプリの使い方に関するリスト画面のView|
|HowToUseStudyView|学習機能の使い方を説明する画面のView|
|HowToUseQuestionListView|問題リスト機能の使い方を説明する画面のView|
|HowToUseMedicineListView|薬リスト機能の使い方を説明する画面のView|
|ReferenceView|アプリで使用されている薬名の引用元を表示する画面のView|

### ViewModel
|ファイル名|解説・概要|
|--|--|
|ModeSelectionViewModel|学習画面で指定された問題リストや出題設定を管理するクラス。その設定の条件にあった問題をCoreDataから取得する。|
|CreateQuestionListViewModel|ユーザーからの情報の入力とそれに基づく問題リストの作成を仲介するクラス。CreateQuestionListModelから問題リストのデータを受け取り、CreateQuestionListViewに表示する。一方で、CreateQuestionListViewでユーザーから受け取った薬名の選択の状態を管理する。この情報を元に問題リストを作成し、CoreDataに保存する。|
|QuestionsViewModel|CoreDataから、保存した問題リストの情報を取得し、QuestionsViewに渡すクラス|
|MedicineListViewModel|ユーザーからの入力に基づき、表示するリストを切り替えるクラス|

### Model
|ファイル名|解説・概要|
|--|--|
|TabSelection|タブの種類を管理する列挙型|
|QuestionListPickerItem|学習モード選択画面で表示される問題リストを管理する構造体|
|StudyMode|学習モード選択画面で「商品名→一般名」と「一般名→商品名」の出題設定を管理する列挙型|
|QuestionSelectionMode|学習モード選択画面で「全ての問題」と「わからない問題」の出題設定を管理する列挙型|
|UserDefaultsKeys|UserDefaultsに値を保持するために使用するキーを管理する列挙型。本アプリでは、ユーザーが指定した出題設定の状態を保持することにより、アプリを閉じて再び開いた際に、前回の出題設定からスタートできる。|
|StudyItem|学習画面で出題する薬名データを管理するための構造体|
|AnswerButtonType|学習で使用する正解ボタン・不正解ボタン・戻るボタンを種類を管理する列挙型|
|StudyResult|学習結果（正解・不正解・未回答）を管理する列挙型|
|CSVLoader|CSVファイルからの薬名データの読み込みを担当するクラス|
|CreateQuestionListModel|CSVファイルから薬名データを、CoreDataからユーザー独自の薬名データを取得し、それらを統合して、問題リスト作成画面に表示するデータを提供するクラス|
|QuestionListMode|問題リスト作成画面で、問題リストを作成するか編集するかの状態を管理する列挙型|
|MedicineListItem|問題リストを作成・編集の際に、薬名のデータが選択・非選択されているかを管理する目的で使用する構造体|
|MedicineItem|薬名データを管理する構造体。商品名と一般名の対応、および、薬のカテゴリを一つのデータにまとめる。|
|MedicineCategory|薬のカテゴリを管理する列挙型。指定されたカテゴリに対応した薬データをCSVファイルから取得するモデルとしての役割も果たす。|
|AddMedicineField|ユーザー独自の薬名をリストに追加する画面（AddMedicineView）でテキストフィールドにフォーカスを当てる機能を管理するための列挙型|
|SettingsListItem|設定の項目を管理する列挙型|
|HowToUse|アプリの使い方に関する項目を管理する列挙型|

### Others
|ファイル名|解説・概要|
|--|--|
|AppDelegate|アプリのライフサイクルイベントを処理するためのデリゲートクラス。本アプリでは、アプリの起動時に、Google AdMobのバナー広告の初期化を行う。また、初回のみ、ユーザーへのトラッキングの許可をリクエストする。|
|Persistence|CoreDataで使用するPersistentControllerの構造体を定義する。|

## 7. シーケンス図
### 学習
```mermaid
sequenceDiagram
    participant View
    participant ViewModel
    participant CoreData
    View->>ViewModel: 出題設定を指定
    ViewModel->>CoreData: 指定された薬名データをリクエスト
    CoreData->>ViewModel: 薬名データ：分類（内用薬・注射薬・外用薬）、商品名、一般名、商品名→一般名の学習結果、一般名→商品名の学習結果
    ViewModel->>View: 薬名データを表示
    View->>CoreData: 学習結果を保存
```
<br>

### 問題リスト（作成）
```mermaid
sequenceDiagram
    participant View
    participant ViewModel
    participant Model
    participant CSV File
    participant CoreData
    View->>ViewModel: 問題リスト作成画面に表示する薬名データをリクエスト
    ViewModel->>Model: 薬名データをリクエスト
    Model->>CSV File: 薬名データをリクエスト
    CSV File->>Model: 薬名データ：内用薬・注射薬・外用薬の商品名および一般名
    Model->>CoreData: 薬名データをリクエスト
    CoreData->>Model: 薬名データ：カスタムの商品名および一般名
    Model->>Model: 取得した薬名データを統合
    Model->>ViewModel: 統合した薬名データ
    ViewModel->>View: 薬名データを表示
    View->>ViewModel: 問題リストに追加する薬名（出題したい薬名）を選択
    ViewModel->>CoreData: 薬名データを保存
    CoreData->>ViewModel: 薬名データ：分類（内用薬・注射薬・外用薬）、商品名、一般名、商品名→一般名の学習結果、一般名→商品名の学習結果、問題ID
    ViewModel->>View: 薬名データを表示
```
<br>

### 問題リスト（編集）
```mermaid
sequenceDiagram
    participant View
    participant ViewModel
    participant Model
    participant CSV File
    participant CoreData
    View->>ViewModel: 問題リスト編集画面に表示する薬名データをリクエスト
    ViewModel->>Model: 薬名データをリクエスト
    Model->>CSV File: 薬名データをリクエスト
    CSV File->>Model: 薬名データ：内用薬・注射薬・外用薬の商品名および一般名
    Model->>CoreData: 薬名データをリクエスト
    CoreData->>Model: 薬名データ：カスタムの商品名および一般名
    Model->>Model: 取得した薬名データを統合
    Model->>ViewModel: 統合した薬名データ
    ViewModel->>CoreData: 「問題リストの作成」で保存した薬名データをリクエスト
    CoreData->>ViewModel: 薬名データ：分類（内用薬・注射薬・外用薬）、商品名、一般名、商品名→一般名の学習結果、一般名→商品名の学習結果、問題ID
    ViewModel->>ViewModel: 統合した薬名データのうち、「問題リストの作成」で保存した薬名データと一致するデータは既に選択された状態にする
    ViewModel->>View: 薬名データを表示
    View->>ViewModel: 問題リスト編集（問題の追加、もしくは、削除）
    ViewModel->>CoreData: 薬名データを保存
    CoreData->>ViewModel: 薬名データ：分類（内用薬・注射薬・外用薬）、商品名、一般名、商品名→一般名の学習結果、一般名→商品名の学習結果、問題ID
    ViewModel->>View: 薬名データを表示
```
<br>

### 薬リスト
```mermaid
sequenceDiagram
    participant View
    participant ViewModel
    participant Model
    participant CSV File
    participant CoreData
    View->>ViewModel: 薬リスト画面に表示する薬名データをリクエスト
    ViewModel->>Model: 薬名データをリクエスト
    Model->>CSV File: 薬名データをリクエスト
    CSV File->>Model: 薬名データ：内用薬・注射薬・外用薬の商品名および一般名
    Model->>ViewModel: 薬名データ：内用薬・注射薬・外用薬の商品名および一般名
    ViewModel->>View: 薬名データを表示
    View->>CoreData: ユーザー独自の薬名データを追加
    CoreData->>View: 追加された薬名データを薬リストに表示
```
<br>

上の図はJavaScriptライブラリ Mermaidを利用して作図しています。<br>
[Mermaidについて詳細はこちらから確認できます。](https://mermaid-js.github.io/mermaid/#/)<br>


## 8. E-R図
### 問題リストと問題のリレーション
```mermaid
erDiagram
    QuestionList ||--|{ Question : contains
    QuestionList {
    	UUID ListID PK
    	String ListName
    	Date CreatedDate
    	Int16 NumberOfQuestions
    }
    Question {
    	UUID QuestionID PK
    	UUID ListID FK
    	String BrandName
    	String BrandToGenericResult
    	String GenericName
    	String GenericToBrandResult
    	String Category
    }
```
<br>

## 9. 工夫したコード
### 両面に文字が記載されているカードがめくられるアニメーションを実装しました。
カードがめくられる様子<br>
<img width="250" src="ScreenShots/Explanation_6.gif"><br>

めくられるカードを実装したコード
https://github.com/tas5521/MedicineNameQuiz/blob/a1da25e645e4eeb0f7455e1c69b70c3d0c2890a3/MedicineNameQuiz_Sagae/View/Study/StudyView.swift#L46-L54
https://github.com/tas5521/MedicineNameQuiz/blob/a1da25e645e4eeb0f7455e1c69b70c3d0c2890a3/MedicineNameQuiz_Sagae/View/Study/StudyView.swift#L139-L149
https://github.com/tas5521/MedicineNameQuiz/blob/a1da25e645e4eeb0f7455e1c69b70c3d0c2890a3/MedicineNameQuiz_Sagae/View/Study/StudyView.swift#L151-L230

### 解説
カードがタップされると、横方向に回転し、裏面の答えが表示されます。<br>
まず、カードのViewを作成しました。<br>
```swift
 // カードのView 
 private var flipCardView: some View {
     // Viewに必要な値の定義の部分 
     // カードの幅 
     let width: CGFloat = 260 
     // カードの高さ 
     let height: CGFloat = 180 
     // 商品名か一般名かを示すテキスト 
     let brandOrGenericLabel: String = { 
         switch studyMode { 
         case .brandToGeneric: 
             isFront ? "商品名":"一般名" 
         case .genericToBrand: 
             isFront ? "一般名":"商品名" 
         } // switch ここまで 
     }() // brandOrGenericLabel ここまで 
  
     // Viewの定義の部分 
     // ZStack を返す 
     return ZStack { 
         // 角の丸い長方形を配置 
         RoundedRectangle(cornerRadius: 20) 
             // 白で塗る 
             .fill(.white) 
             // 幅高さを指定 
             .frame(width: width, height: height) 
             // 影をつける 
             .shadow(color: .gray, radius: 2, x: 0, y: 0) 
         // 左上のテキストを表面ではQ、裏面ではAにする 
         Text(isFront ? "Q.":"A.") 
             // カードの左上に配置 
             .offset(CGSize(width: -100, height: -60.0)) 
         // 商品名か一般名かを示すテキストを配置 
         Text(brandOrGenericLabel) 
             // カードの上部に配置 
             .offset(CGSize(width: 0, height: -60.0)) 
         // 薬の名前のテキスト 
         Text(medicineName) 
             // 幅高さを指定 
             .frame(width: width - 50, height: height - 50) 
     } // ZStack ここまで 
```
<br>


カードの回転エフェクトは.rotation3DEffectにより実装しました。<br>
cardDegree変数の値を変更することで、カードの回転の角度を指定します。<br>
カードはy軸（縦軸）の周りに回転します。<br>
```swift
     // 回転エフェクトをつける 
     .rotation3DEffect(Angle(degrees: cardDegree), axis: (x: 0, y: 1, z: 0)) 
```
<br>

カードがタップされたかどうかは.onTapGestureで検知しました。<br>
ここでは、カードに表示されている文字とその色を適切なタイミングで変更するため、Concurrencyの機能を使っています。<br>
```swift
     // カードがタップされたら 
     .onTapGesture { 
         Task { 
             // カードをめくる
             await flipCard() 
         } // Task ここまで 
     } // onTapGesture ここまで 
```
<br>

まず、isCardFlipped.toggle()により、カードがめくられているかどうかを切り替えます。<br>
isCardFlippedがtrueになると、0.1秒（duration）かけてカードが90°回転します。その間を、Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000)) により、待機します。<br>
カードが90°回転したら、一瞬のうちにカードをさらに180°回転し、回転の角度を270°にします。これにより、文字の向きを合わせます。<br>
さらにこの瞬間に、isFront.toggle()により、カードの表と裏を切り替えます。これにより、カードに表示される商品名と一般名の文字が切り替わります（文字の色も黒と赤で切り替わります）。<br>
さらに、0.1秒（duration）かけてカードの回転角度を360°にします。<br>
このようにして、一方の面に問題が、もう一方の面に答えが表示されているカードの回転を実装しています。<br>
```swift
 // カードをめくるメソッド 
 private func flipCard() async { 
     // カードがめくられているか、めくられていないかを、切り替え 
     isCardFlipped.toggle() 
     // カードを半分めくるアニメーション 
     withAnimation(.linear(duration: duration)) { 
         cardDegree = isCardFlipped ? 90 : 270 
     } // withAnimation ここまで 
     do { 
         // カードが半分めくられるまで待つ 
         try await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000)) 
     } catch { 
         // デバッグエリアにエラーメッセージを表示 
         print("Error: \(error)") 
     } // do-try-catch ここまで 
     // カードのめくられた角度を一気に180°回して文字の向きを表面に合わせる 
     cardDegree = isCardFlipped ? 270 : 90 
     // 表面と裏面を切り替え 
     isFront.toggle() 
     // カードを半分めくるアニメーション 
     withAnimation(.linear(duration: duration)) { 
         cardDegree = isCardFlipped ? 360 : 0 
     } // withAnimation ここまで 
 } // flipCard ここまで 
```
<br>

## 10. その他リンク
- [アプリ紹介ホームページ](https://tas5521.github.io/MedicineNameQuiz/index.html)<br>
- [作成者のXアカウント](https://x.com/ta_s11152)<br>
- [薬名のリストを作成するためにPythonで作成したデスクトップアプリ](https://github.com/tas5521/CreateMedicineNameDataSet)<br>
- [作成中の他のアプリ（数独ソルバー）](https://github.com/tas5521/SudokuSolver)