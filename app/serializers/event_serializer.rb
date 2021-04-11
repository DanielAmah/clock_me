class EventSerializer < ActiveModel::Serializer
  attributes :id, :description, :clock_in, :clock_out, :profession, :user, :time_spend

  def profession
    object.user_profession.profession.name
  end

  def user
    object.user_profession.user.email
  end

  def time_spend
    if object.clock_out
      Time.at(object.clock_out - object.clock_in).utc.strftime("%H:%M:%S")
    end
  end
end
