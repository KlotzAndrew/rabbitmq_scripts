require 'bunny'

msg = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

conn = Bunny.new
conn.start

ch = conn.create_channel
q = ch.queue("test_task_queue", :durable => true)

q.publish(msg, :persistent => true)
puts " [x] Sent #{msg}"

conn.close
