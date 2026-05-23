# frozen_string_literal: true

module ReportsHelper
  def owner?(resource)
    resource.user == current_user
  end
end
