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
  
  def delete_vote
    @vote = Vote.first(:user_id => session.user.id, :votable_id => params[:article_id], :votable_type => "Article")
    @vote.destroy
    @article = Article.get(params[:article_id])
    @article.points += params[:score].to_i
    @article.save
    if request.ajax?
      display @article
    else
      redirect resource(@article), :message => {:notice => "Vote was successfully created"}
    end
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

  def create
    @vote = Vote.new
    @vote.vote = params[:vote].to_i
    @vote.votable_type = "Article"
    @vote.votable_id = params[:article_id]
    @vote.user_id = session.user.id
    @article = Article.get(params[:article_id].to_i)
    if @vote.save
      if (params[:other_arrow].to_i == 1)
        vote = Vote.first(:user_id => session.user.id, :votable_id => params[:article_id], :votable_type => "Article")
        vote.destroy
      end
      @article.points += params[:score].to_i
      @article.save
      if request.ajax?
        display @article
      else
        redirect resource(@article), :message => {:notice => "Vote was successfully created"}
      end
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