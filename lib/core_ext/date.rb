require 'date'
class Date
  def self.valid_date?( str, format="%d.%m.%Y" )
    self.strptime(str,format) rescue false
  end
end
