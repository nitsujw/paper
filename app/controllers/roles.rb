class Roles < Application
  # provides :xml, :yaml, :js
  
  before :authenticate

  def index
    @roles = Role.all
    display @roles
  end

  def show(id)
    @role = Role.get(id)
    raise NotFound unless @role
    display @role
  end

  def new
    only_provides :html
    @role = Role.new
    display @role
  end

  def edit(id)
    only_provides :html
    @role = Role.get(id)
    raise NotFound unless @role
    display @role
  end

  def create(role)
    @role = Role.new(role)
    if @role.save
      redirect resource(@role), :message => {:notice => "Role was successfully created"}
    else
      message[:error] = "Role failed to be created"
      render :new
    end
  end

  def update(id, role)
    @role = Role.get(id)
    raise NotFound unless @role
    if @role.update_attributes(role)
       redirect resource(@role)
    else
      display @role, :edit
    end
  end

  def destroy(id)
    @role = Role.get(id)
    raise NotFound unless @role
    if @role.destroy
      redirect resource(:roles)
    else
      raise InternalServerError
    end
  end
  
private

  def authenticate
    unless session.user.admin?
      redirect resource(:quotes), :message => {:notice => "Not your tag!"}
    end
  end

end # Roles
