# frozen_string_literal: true

module ApplicationHelper
  def nav_active_location_class(path)
    'active' if request.path == path
  end
end
