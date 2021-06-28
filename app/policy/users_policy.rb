class UsersPolicy

  
  def initialize(user)
    @user = user
  end

  def admin?
    @user.role.status == 'admin'
  end

  def staff?
    @user.role.status == 'staff'
  end
end