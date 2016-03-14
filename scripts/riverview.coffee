# Description:
#   Looks up showtimes at the Riverview theater
#

cheerio = require('cheerio')

module.exports = (robot) ->

  robot.respond /riverview/i, (msg) ->
    robot.http("http://www.riverviewtheater.com/").get() (err, res, body) ->
      if err
        msg.send "Oops: #{err}"
      else
        $ = cheerio.load(body)
        now_showing = for element in $('.blog-sidebar .playing li').toArray()
          name = $(element).find('a').text().trim()
          time = $(element).contents().last().text().trim()
          [name, time]

        msg.send "Now showing:"
        for [name, time] in now_showing
          msg.send "#{time} #{name}"
