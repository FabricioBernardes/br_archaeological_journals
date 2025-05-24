class BibliographicReferencesController < ApplicationController
  before_action :set_bibliographic_reference, only: %i[show edit update destroy]

  # GET /bibliographic_references or /bibliographic_references.json
  def index
    @bibliographic_references = if params[:query].present?
                                  BibliographicReference.where("title ILIKE ?", "%#{params[:query]}%")
                                else
                                  BibliographicReference.all
                                end
    respond_to do |format|
      format.html
      format.json { render json: @bibliographic_references.select(:id, :title, :reference_type, :authors, :year, :publisher, :publication_location, :doi, :language) }
    end
  end

  # GET /bibliographic_references/1 or /bibliographic_references/1.json
  def show
  end

  # GET /bibliographic_references/new
  def new
    @bibliographic_reference = BibliographicReference.new
  end

  # GET /bibliographic_references/1/edit
  def edit
  end

  # POST /bibliographic_references or /bibliographic_references.json
  def create
    @bibliographic_reference = BibliographicReference.new(bibliographic_reference_params)

    respond_to do |format|
      if @bibliographic_reference.save
        format.html { redirect_to @bibliographic_reference, notice: "Bibliographic reference was successfully created." }
        format.json { render :show, status: :created, location: @bibliographic_reference }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bibliographic_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bibliographic_references/1 or /bibliographic_references/1.json
  def update
    respond_to do |format|
      if @bibliographic_reference.update(bibliographic_reference_params)
        format.html { redirect_to @bibliographic_reference, notice: "Bibliographic reference was successfully updated." }
        format.json { render :show, status: :ok, location: @bibliographic_reference }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bibliographic_reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bibliographic_references/1 or /bibliographic_references/1.json
  def destroy
    @bibliographic_reference.destroy!

    respond_to do |format|
      format.html { redirect_to bibliographic_references_path, status: :see_other, notice: "Bibliographic reference was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bibliographic_reference
    @bibliographic_reference = BibliographicReference.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bibliographic_reference_params
    params.require(:bibliographic_reference).permit(:reference_type, :authors, :year, :title, :publisher, :publication_location, :doi, :language)
  end
end
