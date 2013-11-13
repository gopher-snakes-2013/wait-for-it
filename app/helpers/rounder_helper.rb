module RounderHelper
  def self.round_up(hour, mins)
    rounded_minutes = self.round_minutes(mins.to_i)
    hour = hour.to_i
    if rounded_minutes == 60
      rounded_minutes = 0
    elsif rounded_minutes > 60
      rounded_minutes = 5
      if hour < 12
        hour += 1
      else
        hour = 1
      end
    end

    { hour: hour.to_s, minutes: self.format(rounded_minutes) }
  end

  def self.round_minutes(minutes)
    if minutes % 5 == 0
      minutes
    else
      minutes + (5 - minutes % 5)
    end
  end

  def self.format(minutes)
    if minutes < 10
      "0" + minutes.to_s
    else
      minutes.to_s
    end
  end
end