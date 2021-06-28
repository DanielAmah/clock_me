class GetProfessionsAscQuery
  def call(relation)
    relation.order(name: :asc)
  end
end