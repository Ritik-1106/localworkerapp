class HomesController < ApplicationController
  before_action :authenticate_user!

  def contractor
    @contractor = current_user
  end

  def worker
    @worker = current_user
  end
def index
end
end
