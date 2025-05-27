class AuthorRefsController < ApplicationController
  def index
    author_refs = if params[:query].present?
                    AuthorRef.where("name ILIKE ?", "%#{params[:query]}%")
                  else
                    AuthorRef.all
                  end
    respond_to do |format|
      format.json { render json: author_refs.select(:id, :name) }
    end
  end

  def create
    author_ref = AuthorRef.find_or_create_by(name: params[:author_ref][:name])
    render json: { id: author_ref.id, name: author_ref.name }
  end
end
