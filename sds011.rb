require_relative 'reader'

# change this according to what device your sensor shows up as on your system...
DEVICE = '/dev/cu.usbserial-1420'

reader = Reader.new(DEVICE)
loop do
  packet = reader.read_packet
  
  if packet.nil?
    puts "Received data is malformed. Are you reading from the right device? (#{DEVICE})"
  else
    # puts packet
    puts "PM2.5: #{packet.pm25} µg/m3"
    puts "PM10: #{packet.pm10} µg/m3"
    puts
  end

  sleep 1
end
