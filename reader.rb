require 'rubyserial'

require_relative 'packet'

class Reader
  def initialize(device)
    @serialport = Serial.new(device) # Defaults to 9600 baud, 8 data bits, and no parity
  end

  def read_packet
    packet = Packet.new(@serialport.read(10))

    return nil unless packet.expected_values_correct? && packet.check_sum_correct?

    packet
  end
end
