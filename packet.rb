# according to https://ecksteinimg.de/Datasheet/SDS011%20laser%20PM2.5%20sensor%20specification-V1.3.pdf

class Packet
  BYTE_NAMES = [
    'Message Header',
    'Commander No.',
    'DATA1',
    'DATA2',
    'DATA3',
    'DATA4',
    'DATA5',
    'DATA6',
    'Check-sum',
    'Message tail'
  ]

  MESSAGE_HEADER_EXPECTED_VALUE = 'aa'
  COMMANDER_NO_EXPECTED_VALUE = 'c0'
  MESSAGE_TAIL_EXPECTED_VALUE = 'ab'

  def initialize(data)
    hex = data.unpack('H*').first
    
    @bytes = []
    hex.chars.each_slice(2) do |slice| 
      @bytes << slice.join
    end
  end

  def message_header
    @bytes[0]
  end

  def commander_no
    @bytes[1]
  end

  def data1
    @bytes[2]
  end

  def data2
    @bytes[3]
  end

  def data3
    @bytes[4]
  end

  def data4
    @bytes[5]
  end

  def data5
    @bytes[6]
  end

  def data6
    @bytes[7]
  end

  def check_sum
    @bytes[8]
  end

  def message_tail
    @bytes[9]
  end

  def expected_values_correct?
    message_header == MESSAGE_HEADER_EXPECTED_VALUE &&
      commander_no == COMMANDER_NO_EXPECTED_VALUE &&
      message_tail == MESSAGE_TAIL_EXPECTED_VALUE
  end

  def check_sum_correct?
    sum = byte_to_i(data1) + 
      byte_to_i(data2) + 
      byte_to_i(data3) + 
      byte_to_i(data4) + 
      byte_to_i(data5) + 
      byte_to_i(data6)
    
    i_to_byte(sum % 256) == check_sum
  end

  def to_s
    @bytes.map.with_index do |byte, index|
      "#{BYTE_NAMES[index]}: #{byte}"
    end.join("\n")
  end

  def pm25
    ((pm25_high * 256) + pm25_low) / 10.0
  end

  def pm10
    ((pm10_high * 256) + pm10_low) / 10.0
  end

  private

  def byte_to_i(byte)
    [byte].pack('H*').ord
  end

  def i_to_byte(i)
    i.chr.unpack('H*').first
  end

  def pm25_low
    byte_to_i(data1)
  end

  def pm25_high
    byte_to_i(data2)
  end

  def pm10_low
    byte_to_i(data3)
  end

  def pm10_high
    byte_to_i(data4)
  end
end
