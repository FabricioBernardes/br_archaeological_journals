class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :require_contributor_or_admin, only: %i[new create edit update destroy]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
    @article.edition_id = params[:edition_id] if params[:edition_id]
    @editions = Edition.all.includes(:scientific_journal).order('scientific_journals.name, editions.volume')
    @bibliographic_references = BibliographicReference.all
  end

  # GET /articles/1/edit
  def edit
    @editions = Edition.all.includes(:scientific_journal).order('scientific_journals.name, editions.volume')
    @keywords = Keyword.all
    @bibliographic_references = BibliographicReference.all
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_path, status: :see_other, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def require_contributor_or_admin
    return if current_user&.contributor? || current_user&.admin?

    redirect_to articles_path, alert: 'Você não tem permissão para realizar esta ação.'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :abstract, :doi, :article_url, :language, :research_theme, :publication_type, :main_methodology,
                                    :institutions, :data_source, :database_citation, :states, :spatial_analysis, :laboratory_methods, :datings, :edition_id, keyword_ids: [], bibliographic_reference_ids: [], author_ids: [])
  end
end
