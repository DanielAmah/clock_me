class EventQuery
  def all_events_in_desc(relation)
    relation&.where(visible: true).order(created_at: :desc)
  end

  def current_user_events_in_desc(relation, current_user)
    relation&.where(users: {id: current_user&.id}, visible: true)&.order(created_at: :desc)
  end
end