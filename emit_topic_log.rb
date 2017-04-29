require 'bunny'

conn = Bunny.new
conn.start

ch       = conn.create_channel
x        = ch.topic("test_topic_logs")
severity = ARGV.shift || "anonymous.info"
msg      = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

x.publish(msg, :routing_key => severity)
puts " [x] Sent #{severity}:#{msg}"

conn.close
