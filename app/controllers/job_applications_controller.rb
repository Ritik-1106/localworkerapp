class JobApplicationsController < ApplicationController
before_action :set_job, only: [ :new, :create, :total_applicants ] # Ensure job is set for specific actions
before_action :set_job_application, only: [ :show ]

def new
  @job_application = @job.job_applications.new
end

# POST /jobs/:job_id/job_applications
def create
  @job_application = @job.job_applications.new(job_application_params)
  @job_application.worker_id = current_user.id  # Set worker_id automatically based on the logged-in user

  if @job_application.save
    redirect_to @job, notice: "Job application was successfully created."
  else
    render :new
  end
end

def total_applicants
  if current_user.contractor?
    @applicants = JobApplication.where(job_id: params[:job_id])
  else
    redirect_to jobs_path, alert: "You do not have permission to view this page."
  end
end
def my_applications
  @my_applications = current_user.job_applications
  @jobs = Job.where(id: @my_applications.pluck(:job_id))
end

def show
  if current_user.contractor?
    @job_application = JobApplication.find(params[:id])
    @worker = User.find(@job_application.worker_id)  # Fetch the worker who applied
    @profile = Profile.find_by(user_id: @worker.id)  # Find the worker's profile
  else
    redirect_to jobs_path, alert: "You do not have permission to view this page."
  end
end

private

def job_application_params
  params.require(:job_application).permit(:description, :softskills, :expected_salary, :status)
end

# Set the job based on the job_id from the URL
def set_job
  @job = Job.find_by(id: params[:job_id])
  redirect_to jobs_path, alert: "Job not found." if @job.nil?
end

def set_job_application
  @job_application = JobApplication.find(params[:id])
end
end
