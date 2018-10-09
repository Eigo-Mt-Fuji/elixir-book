# LINE Account作成

## Agenda

* LINE Developer Accountを作成
    * https://developers.line.me/ja/
* Line プロバイダーを作成（企業名など)
* Line チャンネルを作成（BotならMessengerなど)
* Webhook送信を利用するに変更（WebhookをElixirで作成)
* Webhook URLを入力（Herokにデプロイしておく)

## チャットフロー

* LINEアプリを開く
* Elicチャンネルに登録
* 適当なメッセージをチャンネルにつぶやく # ボット（Elixirで実装したWebhook API）にリクエストが送信される
* ボットから返信が届く
------

## ボットの処理フロー(概要)
```
1. 署名を検証する
2. リクエストボディを取得
3. 応答メッセージを送信する
4. レスポンスを返却
```

## ボットの処理フロー(詳細)
1. 署名を検証する

```
X-Line-Signatureリクエストヘッダーを取得
チャネルシークレットを秘密鍵として、HMAC-SHA256アルゴリズムを使用してリクエストボディのダイジェスト値を取得
ダイジェスト値をBase64エンコード
リクエストヘッダーにある署名が一致することを確認
```
2. リクエストボディを取得
```
{
    "events": [
        {
            "type": "message",
            "timestamp": 12345678,
            "source": {
                "type": "user",
                "userId": "<送信元ユーザID>"
            },
            "replyToken": "<リプライトークン>",
            "message": {
                "type": "text",
                "id": "<メッセージID>",
                "text":   "<メッセージのテキスト>"
            }
        }
    ]
}
```
3. 応答メッセージを送信する (Webhookから送信されるHTTP POSTリクエストは、失敗しても再送されません。)
```
POST https://api.line.me/v2/bot/message/reply
```
4. レスポンスを返却 (ボットアプリのサーバーにWebhookから送信されるHTTP POSTリクエストには、ステータスコード200を返す必要があります。)
```
ステータスコード: 200

