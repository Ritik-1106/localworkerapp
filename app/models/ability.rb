class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role == "contractor"
      can :manage, Job, contractor_id: user.id
      can :read, JobApplication, job: { contractor_id: user.id }
    elsif user.role == "worker"
      can :read, Job
      can :create, JobApplication
      can :manage, JobApplication, worker_id: user.id
    elsif user.admin?
      can :manage, :all
    else
      can :read, Job
    end
  end
end
