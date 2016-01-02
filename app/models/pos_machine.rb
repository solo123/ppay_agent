class PosMachine < ActiveRecord::Base
  def self.find_machine(code)
    if !code || code.strip.empty?
      nil
    else
      c = code.strip
      PosMachine.find_or_create_by(serial_number: c)
    end
  end
end
