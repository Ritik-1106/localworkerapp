class JobsController < ApplicationController
  before_action :set_job, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
   if current_user.contractor?
    @jobs = current_user.jobs

   elsif current_user.worker?
    @jobs = Job.all
   end
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      redirect_to @job, notice: "Job posted successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: "Job updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, notice: "Job deleted."
  end
  def total_applicants
     JobApplication.where(job_id: params[:job_id])
  end

  private
  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:name, :description, :salary, :location, :category_id, :vacancies)
  end
end
