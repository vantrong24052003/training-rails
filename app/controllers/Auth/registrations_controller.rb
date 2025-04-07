# frozen_string_literal: true

class Auth::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params

  # POST /resource
  def create
    super do |resource|
      resource.add_role(:users) if resource.persisted?
      # binding.pry
    end
  end

  def new
    super
  end

  private
end
