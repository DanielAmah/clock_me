class Event < ApplicationRecord
  belongs_to :user_profession
  validates_presence_of :description, :clock_in
  validates :description, length: { minimum: 10, message: "is too short!" }
  
  validate :clock_in_time_after_clock_out_time
  validate :clock_out_time_clock_in_time_diff_within_24h

  def clock_in_time_after_clock_out_time
    return if clock_out.nil? || clock_in.nil?
    if clock_out < clock_in
      errors.add(:clock_out, "must be after the clock_in time")
    end
  end

  def clock_out_time_clock_in_time_diff_within_24h
    return if clock_out.nil? || clock_in.nil?

    if (clock_out - clock_in).to_f / (60 * 60).round() > 24
      errors.add(:clock_out, "time diff must be less than 24hours")
    end
  end

end
