class ProfessionsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index]

  before_action :current_profession, only: %i[destroy]

  def index
    professions = profession_in_asc
    render json: professions, each_serializer: ProfessionSerializer
  end

  def create
    profession = Profession.create!(profession_params)
    if profession.valid?
      render json: {profession: ProfessionSerializer.new(profession).as_json, message: "New profession created!"}
    end
  end

  def destroy
    if user_policy.staff?
      raise ExceptionHandler::Forbidden, "Need admin privileges!"
    end
    current_profession.destroy!
    render json: { message: 'Profession destroyed successfully' }
  end

  private

  def current_profession
    @current_profession = Profession.find(params[:id])
  end

  def profession_params
    params.require(:profession).permit(:name)
  end

  def user_policy
    UsersPolicy.new(@current_user)
  end

  def profession_in_asc
    professions =  professions = Profession.all
    GetProfessionsAscQuery.new().call(professions)
  end
end