class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.recent
    #@workouts = Workout.all
  end

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
    @workout = Workout.new(workout_params)
    @workout.user = current_user
    if @workout.save
      redirect_to @workout, notice: 'Workout was successfully created.'
      #redirect_to root_path
      #redirect_to @workout, notice: 'Workout was successfully created.'
    else
      @exercise_count = workout_params[:exercise_count].to_i
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

  def workout_params
    params.require(:workout).permit(:date, exercises_attributes: [:id, :name, :weight, :reps, :sets, :duration, :distance, :_destroy])
    #params.require(:workout).permit(:date, exercises_attributes: [:id, :name, :weight, :reps, :sets, :duration, :distance, :_destroy])
  end
end