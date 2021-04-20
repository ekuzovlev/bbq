class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true, length: { maximum: 35 }

  validates :email, presence: true, uniqueness: true

  before_validation :set_name, on: :create

  private

  def set_name
    self.name = 'Незнакомец' if self.name.blank?
  end
end
