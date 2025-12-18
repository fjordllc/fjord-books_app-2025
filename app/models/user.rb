# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :user_icon
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :user_icon_type

  private

  def user_icon_type
    return unless user_icon.attached?
    return if user_icon.content_type.in?(%w[image/jpeg image/jpg image/png image/gif])

    errors.add(:user_icon, 'の形式が不正です（jpg, png, gifのみアップロード可能です）')
  end
end
