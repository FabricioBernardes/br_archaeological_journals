class KeywordsController < ApplicationController
  before_action :set_keyword, only: %i[show edit update destroy]

  # GET /keywords or /keywords.json
  def index
    @keywords = if params[:query].present?
                  Keyword.where("name ILIKE ?", "%#{params[:query]}%")
                else
                  Keyword.all
                end
    respond_to do |format|
      format.html
      format.json { render json: @keywords.select(:id, :name) }
    end
  end

  # GET /keywords/1 or /keywords/1.json
  def show
  end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
  end

  # GET /keywords/1/edit
  def edit
  end

  # POST /keywords or /keywords.json
  def create
    @keyword = Keyword.find_or_create_by(name: keyword_params[:name])
    respond_to do |format|
      format.html { redirect_to @keyword, notice: "Keyword was successfully created." }
      format.json { render json: { id: @keyword.id, name: @keyword.name } }
    end
  end

  # PATCH/PUT /keywords/1 or /keywords/1.json
  def update
    respond_to do |format|
      if @keyword.update(keyword_params)
        format.html { redirect_to @keyword, notice: "Keyword was successfully updated." }
        format.json { render :show, status: :ok, location: @keyword }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1 or /keywords/1.json
  def destroy
    @keyword.destroy!

    respond_to do |format|
      format.html { redirect_to keywords_path, status: :see_other, notice: "Keyword was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_keyword
    @keyword = Keyword.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def keyword_params
    params.require(:keyword).permit(:name)
  end
end
