StarChatOrbiter
====

StarChatOrbiter とは、 StarChat (https://github.com/hajimehoshi/star-chat) の iPhone 向けクライアントです。
とりあえず iPhone のみ対応です。まだ完成していません。いろいろ動作がおかしいところがある気がする。

機能
----
* ひとつの StarChat サーバへの接続
* チャットログの閲覧
* メッセージの投稿
* チャンネル情報の表示

気が向いたら追加する予定の機能
----
* ユーザ情報の変更（ニックネーム、キーワードなど）
* チャンネル情報の変更（トピック、公開状態）
* キーワード反応
* デザインなんとかする
* 未読管理

スクリーンショット
----
![チャンネルログ](http://slightair.github.com/images/etc/sco_channel_log.png)
![チャンネルリスト](http://slightair.github.com/images/etc/sco_channel_list.png)
![メッセージ投稿](http://slightair.github.com/images/etc/sco_post_message.png)
開発中のものです。

開発者向け
----
CocoaPods を使っているのでビルドする前に以下のコマンドを叩きましょう。CocoaPods が入っていなかったらまずはそのインストールからはじめましょう。

    > pod install
    > open StarChatOrbiter.xcworkspace 

プロジェクトを開くのは xcworkspace の方です。たぶんビルドできる気がします。