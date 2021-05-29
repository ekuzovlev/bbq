class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 35 }

  validates :email, presence: true, uniqueness: true

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  def self.find_for_facebook_oauth(access_token)
    email = access_token.info.email
    user = where(email: email).first
    fb_avatar = "#{access_token.info.image}?type=large".gsub('http', 'https')

    user&.update(remote_avatar_url: fb_avatar) unless user&.avatar.present?

    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id
    url = "https://facebook.com/#{id}"

    where(url: url, provider: provider).first_or_create! do |user|
      user.email = email
      user.password = Devise.friendly_token.first(16)
      user.remote_avatar_url = fb_avatar
    end
  end

  def self.find_for_vkontakte_oauth(access_token)
    email = access_token.info.email
    user = where(email: email).first
    vk_avatar = access_token.info.image

    user&.update(remote_avatar_url: vk_avatar) unless user&.avatar.present?

    return user if user.present?

    provider = access_token.provider
    id = access_token.extra.raw_info.id
    url = "https://vk.ru/#{id}"

    where(url: url, provider: provider).first_or_create! do |user|
      user.email = email
      user.password = Devise.friendly_token.first(16)
      user.remote_avatar_url = vk_avatar
    end
  end

  private

  def set_name
    self.name = 'Незнакомец' if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email)
                .update_all(user_id: self.id)
  end
end
