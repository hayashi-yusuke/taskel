# Taskel

## サイトテーマ
仲間と助け合いながらタスク管理ができるSNSサイト

## テーマを選んだ理由
タスク管理アプリを使い始めても、都度タスクを入力する手間が面倒になり、続けることができませんでした。
タスク管理をした方が良いとはわかっていても、
やるべきことを先延ばしにしてしまったり、
こなしても達成感がなく、モチベーションが続かないと
感じている方は多いのではないでしょうか。
また、一人でタスクをこなし続けることへの孤独感も、
続かない原因の一つだと考えました。
そこで、タスクの達成を仲間と共有し、
お互いに助け合いながら前進できるアプリがあれば、
そのような方の助けになると考え、このテーマにしました。

## ターゲットユーザー
- タスク管理が続かない人
- 周りの目があれば頑張れるが、一人だと続かない人

## 主な利用シーン
- 買い物やジムなど、日々のちょっとしたタスクをメモ代わりに使いたい時
- 学習や仕事のやることを書き残したい時
- 誰かと一緒に頑張りたい時

## 設計書
- [uiflows](https://drive.google.com/file/d/1-qoqQdJ-F4PP8Sx-cz6NMU9iQxAllS1X/view?usp=sharing)
- [ER図](https://drive.google.com/file/d/1EHkYD9FGOnsyA6Jyo1Cf4EeEQpci3IiJ/view?usp=sharing)
- [テーブル定義書](https://docs.google.com/spreadsheets/d/1yEiivTNR540vpk96RjcTFUXIYo8kHuITmiom3zclP10/edit?usp=sharing)
- [アプリケーション詳細設計書](https://docs.google.com/spreadsheets/d/1IWnCaqN4XGaDYP_6SGdfsyVtxvZHmV7AQCdDk-jaLak/edit?usp=sharing)
## 開発環境
- OS：Linux(Ubuntu 24.04)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails 8
- IDE：VSCode + EC2(SSH接続)
- データベース：SQLite(開発環境)/ MySQL（本番環境）
- 使用ライブラリ：Bootstrap 5.3, Turbo, kaminari, RSpec, FactoryBot
