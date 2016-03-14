# Description:
#   The robot is agreeable, if not exactly enthusiastic
#

module.exports = (robot) ->
  robot.respond /.*\bok\?$/i, (msg) ->
    msg.send "k"
