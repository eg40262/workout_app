class WorkoutsController < ApplicationController
  before_action :redirect_unless_logged_in, except: :index

  # before_action :authenticate_user! # ユーザーがログインしていることを確認
  #このフィルターにより、ユーザーがログインしていない場合、アクションが実行される前にログインページにリダイレクトされます。
  
  def index
    if user_signed_in?
      if params[:year].present? && params[:month].present?
        selected_year = params[:year].to_i
        selected_month = params[:month].to_i
        Rails.logger.debug "Selected year: #{selected_year}, Selected month: #{selected_month}"
        @workouts = current_user.workouts.where("extract(year from date) = ? AND extract(month from date) = ?", selected_year, selected_month).order(date: :desc).recent
        # @workouts = current_user.workouts.where("extract(year from date) = ? AND extract(month from date) = ?", selected_year, selected_month).recent
      else
        @workouts = current_user.workouts.order(date: :desc).recent
        # @workouts = [] 多分これが表示されない原因だったのだと思う20240606
      end
    else
      @workouts = []
      flash[:alert] = "Please log in to view your workouts."
    end
  end
    #@workouts = current_user.workouts.recent if user_signed_in?
    # 現在ログインしているユーザーに関連する workout オブジェクトをすべて取得します。
    #.recent はスコープメソッドでワークアウトのレコードを新しい順にソートして返す
    #@workouts = Workout.recent
    #@workouts = Workout.all


  def show
    @workout = Workout.find(params[:id])
    @exercises = @workout.exercises
  end

  def new
    @workout = Workout.new
    5.times { @workout.exercises.build }
    #@exercise_count = params[:exercise_count] ? params[:exercise_count].to_i : 1
    #@exercise_count.times { @workout.exercises.build }
    #@workout.exercises.build
  end

  def create
    @workout = Workout.new(workout_params.except(:year, :month)) # yearとmonthを除外
    # @workout = Workout.new(workout_params)
    @workout.user = current_user
    if @workout.save
      redirect_to @workout, notice: 'Workout was successfully created.'
      #redirect_to root_path
      #redirect_to @workout, notice: 'Workout was successfully created.'
    else
      # @exercise_count = workout_params[:exercise_count].to_i 20240605に消した
      render :new
    end
  end

  def edit
    @workout = Workout.find(params[:id])
    (5 - @workout.exercises.size).times { @workout.exercises.build }
  end

  def update
    @workout = Workout.find(params[:id])
    if @workout.update(workout_params)
      redirect_to @workout, notice: 'Workout was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy
    redirect_to workouts_path
  end

  private

  def redirect_unless_logged_in
    redirect_to root_path unless user_signed_in?
  end

  def workout_params
    params.require(:workout).permit(:date, :image, exercises_attributes: [:id, :name, :weight, :reps, :sets, :duration, :_destroy])
    # params.require(:workout).permit(:date, :image, exercises_attributes: [:id, :name, :weight, :reps, :sets, :duration, :distance, :_destroy])
    #params.require(:workout).permit(:date, exercises_attributes: [:id, :name, :weight, :reps, :sets, :duration, :distance, :_destroy])
  end
end
