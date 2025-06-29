class ScientificJournalsController < ApplicationController
  before_action :set_scientific_journal, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :require_contributor_or_admin, only: %i[new create edit update destroy]

  # GET /scientific_journals or /scientific_journals.json
  def index
    @scientific_journals = ScientificJournal.all
  end

  # GET /scientific_journals/1 or /scientific_journals/1.json
  def show
    @scientific_journal = ScientificJournal.find(params[:id])
    per_page = 10
    page = (params[:edicoes_page] || 1).to_i
    editions = @scientific_journal.editions.order(publication_date: :desc, volume: :desc)
    total_pages = (editions.size / per_page.to_f).ceil
    @paginated_editions = editions.offset((page - 1) * per_page).limit(per_page)
    @editions_total_pages = total_pages
    @editions_current_page = page
    @scientific_journal.editions.build if editions.empty?
  end

  # GET /scientific_journals/new
  def new
    @scientific_journal = ScientificJournal.new
  end

  # GET /scientific_journals/1/edit
  def edit
  end

  # POST /scientific_journals or /scientific_journals.json
  def create
    @scientific_journal = ScientificJournal.new(scientific_journal_params)

    respond_to do |format|
      if @scientific_journal.save
        format.html { redirect_to @scientific_journal, notice: "Scientific journal was successfully created." }
        format.json { render :show, status: :created, location: @scientific_journal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @scientific_journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scientific_journals/1 or /scientific_journals/1.json
  def update
    respond_to do |format|
      if @scientific_journal.update(scientific_journal_params)
        format.html { redirect_to @scientific_journal, notice: "Scientific journal was successfully updated." }
        format.json { render :show, status: :ok, location: @scientific_journal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @scientific_journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scientific_journals/1 or /scientific_journals/1.json
  def destroy
    @scientific_journal.destroy!

    respond_to do |format|
      format.html { redirect_to scientific_journals_path, status: :see_other, notice: "Scientific journal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def require_contributor_or_admin
    return if current_user&.contributor? || current_user&.admin?

    redirect_to scientific_journals_path, alert: 'Você não tem permissão para realizar esta ação.'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_scientific_journal
    @scientific_journal = ScientificJournal.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def scientific_journal_params
    params.require(:scientific_journal).permit(:name, :institutional_affiliation, :issn, :thematic_scope, :website_url, :periodicity, :current_status, :foundation_year, :closure_year, :qualis,
                                               :editions)
  end
end
