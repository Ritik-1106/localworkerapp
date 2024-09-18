class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role == "contractor"
      can :manage, Job, contractor_id: user.id
      can :read, Application, job: { contractor_id: user.id }
    elsif user.role == "worker"
      can :read, Job
      can :create, Application
      can :manage, Application, worker_id: user.id
    elsif user.admin?
      can :manage, :all
    else
      can :read, Job
    end
  end
end
