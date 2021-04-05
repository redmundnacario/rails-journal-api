class JournalsController < ApplicationController
  before_action :authorized
  before_action :set_journal, only: [:show, :update, :destroy]

  # GET /journals
  def index
    # @journals = Journal.all
    @journals = Journal.where(user_id: @user.id)
    render json: {
                  status: "Success",
                  message: "Journals loaded.",
                  data: @journals
                  }, status: :ok
  end

  # GET /journals/1
  def show
    render json: {
                  status: "Success",
                  message: "Journal loaded.",
                  data: @journal
                  }, status: :ok
  end

  # POST /journals
  def create
    @journal = Journal.new(journal_params)
    @journal.user_id = @user.id

    if @journal.save
      render json: {
                    status: "Success",
                    message: "Journal created.",
                    data: @journal
                    }, status: :created
    else
      render json: {
                    status: "Error",
                    message: "Journal not created.",
                    data: @journal.errors
                    }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /journals/1
  def update
    if @journal.update(journal_params)
      render json: {
                    status: "Success",
                    message: "Journal updated.",
                    data: @journal
                    }, status: :ok
    else
      render json: {
                    status: "Error",
                    message: "Journal not updated.",
                    data: @journal.errors
                    }, status: :unprocessable_entity
    end
  end

  # DELETE /journals/1
  def destroy
    if @journal.present?
      @journal.destroy
      render json: {
          status: "Success",
          message: "Journal deleted.",
      }, status: 204
    else
      render json: {
          status: "Error",
          message: "Journal not deleted.",
      }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal
      @journal = Journal.where({ id:params[:id], user_id: @user.id })
      return item_not_found
    end

    def item_not_found
      if @journal.length == 0
        render json: {
                      status: "Error",
                      message: "Journal not found.",
                      }, status: 404
      else
        @journal = @journal[0]
      end
    end

    # Only allow a list of trusted parameters through.
    def journal_params
      params.require(:journal).permit(:title, :description)
    end
end
