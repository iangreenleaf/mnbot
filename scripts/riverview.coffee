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
          timeRegexp = /\b(\d?\d:\d\d)\s*([AP]M)/gi
          timeContent = $(element).html()
          times = (match while (match = timeRegexp.exec timeContent)?)
          [name, times]

        msg.send "Now showing:"
        for [name, times] in now_showing
          timeString = ("#{time[1]} #{time[2]}" for time in times)
          msg.send "#{timeString.join " & "} #{name}"
