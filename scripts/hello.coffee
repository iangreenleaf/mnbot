# Description:
#   The robot will say hello
#

module.exports = (robot) ->
  robot.respond /(hi|hello)\b/i, (msg) ->
    msg.send "hello"
