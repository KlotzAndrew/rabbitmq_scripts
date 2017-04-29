require 'bunny'

KEYS      = %w(info warning error)
ERROR_MSG = "Usage: #{$0} #{KEYS}"

abort ERROR_MSG if ARGV.empty?
abort ERROR_MSG unless ARGV.all? { |v| KEYS.include?(v) }

conn = Bunny.new
conn.start

ch = conn.create_channel
x = ch.direct("test_direct_logs")
q = ch.queue("", :exclusive => true)

ARGV.each do |severity|
  q.bind(x, :routing_key => severity)
end

puts " [*] Waiting for logs. To exit press CTRL+C"

begin
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] #{delivery_info.routing_key}:#{body}"
  end
rescue Interrupt => _
  ch.close
  conn.close
end
