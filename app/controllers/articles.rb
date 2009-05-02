class Articles < Application
  # provides :xml, :yaml, :js
  before :ensure_authenticated, :only => :new
  before :authenticate, :only => :edit

  def index
    @articles = Article.all(:order => [:points.desc])
    display @articles
  end

  def show(id)
    @article = Article.get(id)
    raise NotFound unless @article
    display @article
  end

  def new
    only_provides :html
    @article = Article.new
    display @article
  end

  def edit(id)
    only_provides :html
    @article = Article.get(id)
    raise NotFound unless @article
    display @article
  end

  def create(article)
    @article = Article.new(article)
    if @article.save
      redirect resource(@article), :message => {:notice => "Article was successfully created"}
    else
      message[:error] = "Article failed to be created"
      render :new
    end
  end

  def update(id, article)
    @article = Article.get(id)
    raise NotFound unless @article
    if @article.update_attributes(article)
       redirect resource(@article)
    else
      display @article, :edit
    end
  end

  def destroy(id)
    @article = Article.get(id)
    raise NotFound unless @article
    if @article.destroy
      redirect resource(:articles)
    else
      raise InternalServerError
    end
  end

private
  
  def authenticate
    unless session.user.id == User.first(:login => params[:login]).id
      redirect resource(:quotes), :message => {:notice => "Not your tag!"}
    end
  end

end # Articles