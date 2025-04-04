# frozen_string_literal: true

class Auth::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    super do |resource|
      resource.add_role(:users) if resource.persisted?
      # binding.pry
    end
  end
end
