class TrainingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @trainings = current_user.trainings.order(created_at: :desc)
  end

  def new
    @training = Training.new
    @targets = Target.all
  end

  def create
    @training = current_user.trainings.build(training_params)

    if @training.save
      redirect_to trainings_path, notice: "トレーニングを保存しました"
    else
      @targets = Target.all
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @training = current_user.trainings.find(params[:id])
  end
end

private

def training_params
  params.require(:training).permit(:theme, :explanation, :target_id, :custom_target)
end
