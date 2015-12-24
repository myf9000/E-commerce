class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.nil?
        can :read, Product
    elsif user.admin?
        can :manage, :all
    else
        can :read, :all
        can :manage, Product, :user_id => user.id
        can :order, Order, :user_id => user.id
    end
  end
end
