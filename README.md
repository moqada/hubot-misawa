# hubot-misawa

惚れさせ男子データベースから地獄のミサワ画像を返す hubot-scripts。

## Configuration

**HUBOT_MISAWA_404_MESSAGE**

画像がない場合に返すメッセージ

**HUBOT_MISAWA_ERROR_MESSAGE**

エラーが発生した場合に返すメッセージ

**HUBOT_MISAWA_ENABLE_TEXT**

メッセージにキャラクター名とタイトルを含める

## Installation

1. `npm install hubot-misawa --save`
2. "hubot-misawa" を external-scripts.json に追加
4. Reboot Hubot

## Commands

```
hubot misawa - 惚れさせ男子データベースからランダムに画像を返す
hubot misawa <query> - 惚れさせ男子データベースから <query> で検索した画像を返す
hubot misawa bomb <N> <query> - 惚れさせ男子データベースから <query> で検索した画像を <N> 個返す
```
