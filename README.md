# 概要
レストラン、カフェ、居酒屋等の予約を管理するWebアプリケーションです。  
https://noline-tkr-ld.herokuapp.com
# 機能一覧
* 店側、客側の共通機能
  * ログイン機能
  * Oauth認証(twitter)
  * 自分の予約、店に関する変更の通知機能
  * 店検索機能
  * ページネーション機能
* 店側の機能
  * 店登録機能
  * 店の待ち時間設定機能
  * 入店、未入店、キャンセルの3つのステータスで予約を管理
  * 予約時間変更機能(メールで通知)
* 客側の機能
  * 予約、キャンセル機能
  * GoogleMapで店の場所を表示
# 使用している技術一覧
* Ruby 2.5.1
* Ruby on Rails 5.2.3
* PostgreSQL 10.6
* Heroku
* Slim
* Bootstrap4
* ログイン機能はdevise未使用、TwitterのOauth認証にも対応
* 検索にはRansackを使用
* ページネーションにはkaminariを使用
* 店画像はActive Storageを用いて、Amazon Web ServiceのS3にアップロード
* Google Maps API使用時にGeocoderをJavaScriptで使用
