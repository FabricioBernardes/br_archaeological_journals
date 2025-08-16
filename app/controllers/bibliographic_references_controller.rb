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
      format.json { render json: @bibliographic_references.select(:id, :title, :reference_type, :year, :publisher, :publication_location, :doi, :language) }
    end
  end
  
  # GET /bibliographic_references/fetch_doi?doi=10.xxxx/xxxxx
  def fetch_doi
    require 'net/http'
    require 'json'
    
    doi = params[:doi]
    
    if doi.blank?
      render json: { error: "DOI is required" }, status: :unprocessable_entity
      return
    end
    
    # Clean up DOI (remove any https://doi.org/ prefix)
    doi = doi.gsub(%r{^https?://doi\.org/}, '')
    
    # Fetch metadata from Crossref API
    uri = URI.parse("https://api.crossref.org/works/#{doi}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    begin
      request = Net::HTTP::Get.new(uri.request_uri)
      # Add user-agent to comply with Crossref's etiquette
      request['User-Agent'] = "BrazilianArchaeologicalJournals/1.0 (mailto:contact@example.org)"
      
      response = http.request(request)
      
      if response.code == "200"
        data = JSON.parse(response.body)
        
        if data && data["message"]
          message = data["message"]
          
          # Prepare author data
          authors = []
          if message["author"]
            authors = message["author"].map do |author|
              given = author["given"] || ""
              family = author["family"] || ""
              "#{family}, #{given}"
            end
          end
          
          # Extract publication year
          year = nil
          if message["published"] && message["published"]["date-parts"] && message["published"]["date-parts"].first
            year = message["published"]["date-parts"].first.first
          end
          
          # Determine reference type from the "type" field
          reference_type_mapping = {
            "journal-article" => "article",
            "book" => "book",
            "book-chapter" => "book chapter",
            "proceedings-article" => "conference paper"
            # Add more mappings as needed
          }
          reference_type = reference_type_mapping[message["type"]] || message["type"]
          
          # Extract publisher location if available
          publication_location = nil
          
          # Build response data
          response_data = {
            title: message["title"]&.first,
            reference_type: reference_type,
            year: year,
            publisher: message["publisher"],
            publication_location: publication_location,
            doi: message["DOI"],
            language: message["language"],
            authors: authors
          }
          
          render json: response_data
        else
          render json: { error: "Invalid DOI response format" }, status: :unprocessable_entity
        end
      else
        render json: { error: "DOI not found or invalid", code: response.code }, status: :not_found
      end
    rescue => e
      render json: { error: "Error fetching DOI information: #{e.message}" }, status: :internal_server_error
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
    
    # Associa os autores se vierem author_ref_ids
    @bibliographic_reference.author_ref_ids = params[:bibliographic_reference][:author_ref_ids] if params[:bibliographic_reference][:author_ref_ids].present?
    
    # Handle author names from DOI lookup
    if params[:bibliographic_reference][:author_names].present?
      params[:bibliographic_reference][:author_names].each do |author_name|
        # Find or create the author
        author = AuthorRef.find_or_create_by(name: author_name.strip)
        # Add to the bibliographic reference
        @bibliographic_reference.author_refs << author unless @bibliographic_reference.author_refs.include?(author)
      end
    end
    
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
    # Handle author names from DOI lookup
    if params[:bibliographic_reference][:author_names].present?
      @bibliographic_reference.author_refs.clear  # Remove existing authors
      
      params[:bibliographic_reference][:author_names].each do |author_name|
        # Find or create the author
        author = AuthorRef.find_or_create_by(name: author_name.strip)
        # Add to the bibliographic reference
        @bibliographic_reference.author_refs << author unless @bibliographic_reference.author_refs.include?(author)
      end
    end
    
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
    params.require(:bibliographic_reference).permit(:reference_type, :year, :title, :publisher, :publication_location, :doi, :language, author_ref_ids: [])
  end
end
