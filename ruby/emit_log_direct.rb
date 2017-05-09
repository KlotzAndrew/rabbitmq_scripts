require 'bunny'

conn = Bunny.new
conn.start

ch       = conn.create_channel
x        = ch.direct("test_direct_logs")
severity = ARGV.shift || "info"
msg      = ARGV.empty? ? "Hello Wolrd!" : ARGV.join(" ")

x.publish(msg, :routing_key => severity)
puts " [x] Sent '#{msg}'"

conn.close
