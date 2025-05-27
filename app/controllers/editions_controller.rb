class EditionsController < ApplicationController
  before_action :set_edition, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :require_contributor_or_admin, only: %i[new create edit update destroy]

  # GET /editions or /editions.json
  def index
    @editions = Edition.all
  end

  # GET /editions/1 or /editions/1.json
  def show
    @articles = @edition.articles
  end

  # GET /editions/new
  def new
    @edition = Edition.new
    @scientific_journals = ScientificJournal.all
  end

  # GET /editions/1/edit
  def edit
    @scientific_journals = ScientificJournal.all
  end

  # POST /editions or /editions.json
  def create
    @edition = Edition.new(edition_params)

    respond_to do |format|
      if @edition.save
        format.html { redirect_to @edition, notice: "Edition was successfully created." }
        format.json { render :show, status: :created, location: @edition }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /editions/1 or /editions/1.json
  def update
    respond_to do |format|
      if @edition.update(edition_params)
        format.html { redirect_to @edition, notice: "Edition was successfully updated." }
        format.json { render :show, status: :ok, location: @edition }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /editions/1 or /editions/1.json
  def destroy
    @edition.destroy!

    respond_to do |format|
      format.html { redirect_to editions_path, status: :see_other, notice: "Edition was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_edition
    @edition = Edition.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def edition_params
    params.require(:edition).permit(:volume, :publication_date, :editors, :theme, :edition_type, :access_url, :doi, :available_format, :scientific_journal_id)
  end

  def require_contributor_or_admin
    return if current_user&.contributor? || current_user&.admin?

    redirect_to editions_path, alert: 'Você não tem permissão para realizar esta ação.'
  end
end
