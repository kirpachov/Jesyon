class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /activities or /activities.json
  def index
    user_id = user_signed_in? ? current_user.id : -1
    @activities = Activity.all.with_attached_image.where("user_id = ? OR ispriv = ?","#{user_id}", "false")
    filter_applied = params[:filter]
    if(filter_applied == nil)
      @activities = @activities
    else
      @filter = filter_applied
      @activities = Activity.all.where('title ilike ?', "#{filter_applied}%")
      #@json = Activity.all.where('title ilike ?', "#{filter_applied}%").to_json
    end
  end

  # GET /activities/1 or /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities or /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to activities_path, notice: "Activity was successfully created." }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1 or /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: "Activity was successfully updated." }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1 or /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: "Activity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @activity = current_user.activities.find_by(id: params[:id])
    redirect_to activities_path, notice: "ATTENZIONE! Non puoi editare qualcosa che non è tuo!" if @activity.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:title, :body, :ispriv, :date, :time, :user_id, :category_id, :hashtag, :image)
    end
end
