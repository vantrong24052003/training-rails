module ApplicationHelper
  # Helper method to safely check if a user is signed in and has permissions
  # This works both in regular requests and in background jobs (Turbo Stream broadcasts)
  def user_can_edit?(resource)
    # In broadcast context, warden might not be available, so we'll skip authentication
    return false unless defined?(request) && request.env['warden']
    return false unless user_signed_in?

    current_user == resource.user || (current_user&.respond_to?(:has_role?) && current_user&.has_role?(:admin))
  rescue => e
    # If anything goes wrong during the check, fail safe and return false
    Rails.logger.error("Authentication check error: #{e.message}")
    false
  end

  # Helper method to safely check if a user is signed in
  # This works both in regular requests and in background jobs
  def safely_signed_in?
    # In broadcast context, warden might not be available
    return false unless defined?(request) && request.env['warden']
    user_signed_in?
  rescue => e
    # If anything goes wrong during the check, fail safe and return false
    Rails.logger.error("Authentication check error: #{e.message}")
    false
  end
end
