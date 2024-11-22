class User < ApplicationRecord
  has_many :reward_histories, foreign_key: :given_by, class_name: 'RewardHistory'
  has_many :received_rewards, foreign_key: :given_to, class_name: 'RewardHistory'

  validates :name, presence: true
  validates :p5_balance, :reward_balance, numericality: { greater_than_or_equal_to: 0 }
end
