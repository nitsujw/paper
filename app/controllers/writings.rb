class Writings < Application
  # provides :xml, :yaml, :js

  def index
    @writings = Writing.all
    display @writings
  end

  def show(id)
    @writing = Writing.get(id)
    raise NotFound unless @writing
    display @writing
  end

  def new
    only_provides :html
    @writing = Writing.new
    display @writing
  end

  def edit(id)
    only_provides :html
    @writing = Writing.get(id)
    raise NotFound unless @writing
    display @writing
  end

  def create(writing)
    @writing = Writing.new(writing)
    if @writing.save
      redirect resource(@writing), :message => {:notice => "Writing was successfully created"}
    else
      message[:error] = "Writing failed to be created"
      render :new
    end
  end

  def update(id, writing)
    @writing = Writing.get(id)
    raise NotFound unless @writing
    if @writing.update_attributes(writing)
       redirect resource(@writing)
    else
      display @writing, :edit
    end
  end

  def destroy(id)
    @writing = Writing.get(id)
    raise NotFound unless @writing
    if @writing.destroy
      redirect resource(:writings)
    else
      raise InternalServerError
    end
  end

end # Writings
