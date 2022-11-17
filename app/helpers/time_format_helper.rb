module TimeFormatHelper
  def format_duration(time_in_s)
    hours = (time_in_s / (60 * 60)).floor
    minutes = ((time_in_s / 60) % 60).floor
    seconds = time_in_s % 60
    [(hours if hours > 0), minutes, seconds].compact
      .map { |n| "%02d" % n }.join(":")
  end
end
