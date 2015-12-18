class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :mailbox, :conversation, :owner, :find_category, :product_order, :order
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

  def order(id)
    Order.find(id)
  end

  def owner(id)
    User.friendly.find(id)
  end

  def product_order(id)
    Product.friendly.find(id)
  end

  def find_category(id)
    Category.find(id)
  end

  protected

  def layout_by_resource
    if devise_controller?
      "layout_for_form"
    else
      "application"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :description, :password, :current_password, :is_female, :date_of_birth, :avatar) }
  end


end
