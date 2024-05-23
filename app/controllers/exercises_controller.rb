class ExercisesController < ApplicationController
  before_action :set_workout

  def index
    @exercises = @workout.exercises
  end

  def show
    @exercise = @workout.exercises.find(params[:id])
  end

  def new
    @exercise = @workout.exercises.new
  end

  def create
    @exercise = @workout.exercises.new(exercise_params)
    if @exercise.save
      redirect_to [@workout, @exercise]
    else
      render 'new'
    end
  end

  def edit
    @exercise = @workout.exercises.find(params[:id])
  end

  def update
    @exercise = @workout.exercises.find(params[:id])
    if @exercise.update(exercise_params)
      redirect_to [@workout, @exercise]
    else
      render 'edit'
    end
  end

  def destroy
    @exercise = @workout.exercises.find(params[:id])
    @exercise.destroy
    redirect_to workout_exercises_path(@workout)
  end

  private

  def set_workout
    @workout = Workout.find(params[:workout_id])
  end

  def exercise_params
    params.require(:exercise).permit(:name, :weight, :reps, :sets, :duration, :distance)
  end
end