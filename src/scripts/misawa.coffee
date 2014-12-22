# Description:
#   惚れさせ男子データベースからミサワ画像を返す
#
# Configuration:
#   HUBOT_MISAWA_404_MESSAGE - 画像がなかった場合のメッセージ
#   HUBOT_MISAWA_ERROR_MESSAGE - エラーが発生した場合のメッセージ
#   HUBOT_MISAWA_ENABLE_TEXT - メッセージにキャラクター名とタイトルを含める
#
# Commands:
#   hubot misawa - 惚れさせ男子データベースからランダムに画像を返す
#   hubot misawa <query> - 惚れさせ男子データベースから <query> で検索した画像を返す
#   hubot misawa bomb <N> <query> - 惚れさせ男子データベースから <query> で検索した画像を <N> 個返す
#
# Author:
#   moqada
ENABLE_TEXT = process.env.HUBOT_MISAWA_ENABLE_TEXT or false


genMessage = (meigen) ->
  if ENABLE_TEXT
    return "#{meigen.character} 「#{meigen.title}」 #{meigen.image}"
  return "#{meigen.image}"

misawaN = (msg, q, meigens) ->
  if q
    meigens = meigens.filter (meigen) ->
      for key in ['title', 'body', 'character']
        if meigen[key] and meigen[key].indexOf(q) isnt -1
          return true
      return false
  if meigens.length > 0
    misawa = msg.random(meigens)
    res = genMessage misawa
  else
    res = process.env.HUBOT_MISAWA_404_MESSAGE or "画像ない"
  return res

misawa = (msg, q, n) ->
  msg.http('http://horesase-boys.herokuapp.com/meigens.json')
    .get() (err, res, body) ->
      if err
        msg.send process.env.HUBOT_MISAWA_ERROR_MESSAGE or "エラーっぽい"
      else
        meigens = JSON.parse body
        for i in [1..n]
          msg.send misawaN msg, q, meigens

module.exports = (robot) ->
  robot.respond /misawa( +(.*))?/i, (msg) ->
    q = msg.match[2]
    return if q.indexOf("bomb") > -1 if q
    misawa msg, q, 1

  robot.respond /misawa bomb( +(\d+))?( +(.*))?/i, (msg) ->
    n = msg.match[2] or 5
    q = msg.match[4]
    misawa msg, q, n
