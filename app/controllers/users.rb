class Users < Application
  # provides :xml, :yaml, :js

  def show(login)
    @user = User.first(:login => login)
    raise NotFound unless @user
    display @user
  end

  def new
    only_provides :html
    @user = User.new
    display @user
  end

  def edit(login)
    only_provides :html
    @user = User.first(:login => login)
    raise NotFound unless @user
    display @user
  end

  def create(user)
    @user = User.new(user)
    if @user.save
      redirect url(:homepage), :message => "User was successfully created"
    else
      render :new
    end
  end

  def update(login, user)
    @user = User.first(:login => login)
    raise NotFound unless @user
    if @user.update_attributes(user)
       redirect resource(@user), :message => "Your profile was successfully saved"
    else
      display @user, :edit
    end
  end

end # Users