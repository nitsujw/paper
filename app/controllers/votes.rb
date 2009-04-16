class Votes < Application
  provides :js

  def index
    @votes = Vote.all
    display @votes
  end

  def show(id)
    @vote = Vote.get(id)
    raise NotFound unless @vote
    display @vote
  end

  def new
    only_provides :html
    @vote = Vote.new
    display @vote
  end

  def edit(id)
    only_provides :html
    @vote = Vote.get(id)
    raise NotFound unless @vote
    display @vote
  end

  def create(vote)
    @vote = Vote.new
    @vote.vote = params[:vote].to_i
    @vote.votable_type = "Article"
    @vote.votable_id = params[:article_id]
    @vote.user_id = session.user.id
    if @vote.save
      redirect resource(@vote), :message => {:notice => "Vote was successfully created"}
    else
      message[:error] = "Vote failed to be created"
      render :new
    end
  end

  def update(id, vote)
    @vote = Vote.get(id)
    raise NotFound unless @vote
    if @vote.update_attributes(vote)
       redirect resource(@vote)
    else
      display @vote, :edit
    end
  end

  def destroy(id)
    @vote = Vote.get(id)
    raise NotFound unless @vote
    if @vote.destroy
      redirect resource(:votes)
    else
      raise InternalServerError
    end
  end

end # Votes
