class TrainingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @training = Training.new
    @targets = Target.all
  end

  def create
    @training = current_user.trainings.build(training_params)

    if @training.save
      redirect_to trainings_path, notice: "トレーニングを保存しました"
    else
      @targets = Target.all
      render :index, status: :unprocessable_entity
    end
  end
end

private

def training_params
  params.require(:training).permit(:theme, :explanation, :target_id, :custom_target)
end
