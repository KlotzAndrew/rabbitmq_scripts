require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
x = ch.fanout("test_logs")

msg = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

x.publish(msg)
puts " [x] Sent #{msg}"

conn.close
