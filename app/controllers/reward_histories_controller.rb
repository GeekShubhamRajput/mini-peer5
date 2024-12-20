class RewardHistoriesController < ApplicationController
  def index
    @user = User.find(params[:id])
    @rewards = @user.reward_histories
  end

  def new
    @user = User.find(params[:id])
    @users = User.where.not(id: @user.id)
  end

  def create
    giver = User.find(params[:id])
    receiver = User.find(params[:given_to])
    points = params[:points].to_i

    if giver.p5_balance >= points
      RewardHistory.transaction do
        giver.update!(p5_balance: giver.p5_balance - points)
        receiver.update!(reward_balance: receiver.reward_balance + points)
        RewardHistory.create!(given_by: giver.id, given_to: receiver.id, points: points)
      end
      redirect_to reward_histories_path(giver), notice: 'Reward given successfully!'
    else
      redirect_to new_reward_history_path(giver), alert: 'Insufficient P5 balance!'
    end
  end

  def destroy
    binding.pry
    reward = RewardHistory.find(params[:id])
    giver = reward.giver
    receiver = reward.receiver

    RewardHistory.transaction do
      giver.update!(p5_balance: giver.p5_balance + reward.points)
      receiver.update!(reward_balance: receiver.reward_balance - reward.points)
      reward.destroy!
    end
    redirect_to reward_histories_path(giver), notice: 'Transaction reversed successfully!'
  end
end
