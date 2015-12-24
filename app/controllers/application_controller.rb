class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :mailbox, :conversation, :find_category, :find_resource
  layout :layout_by_resource

  
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  

  private

  def find_resource
    class_name = params[:controller].singularize
    klass = class_name.camelize.constantize
    self.instance_variable_set "@" + class_name, klass.find(params[:id])
  end

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def find_category(id)
    Category.find(id)
  end

  protected

  def layout_by_resource
    devise_controller? ? "layout_for_form" : "application"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :description, :password, :current_password,  :avatar) }
  end


end
