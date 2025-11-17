# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
end
