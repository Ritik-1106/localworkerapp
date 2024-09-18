class JobApplicationsController < ApplicationController
  before_action :set_job, only: [ :new, :create, :total_applicants ] # Ensure job is set for specific actions
  before_action :set_job_application, only: [ :update_status ]       # For updating status

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

  # Contractor views all applicants for a job
  def total_applicants
    if current_user.contractor?
      @applicants = @job.job_applications.includes(:worker)
    else
      redirect_to jobs_path, alert: "You do not have permission to view this page."
    end
  end

  # Contractor updates the application status
  def update_status
    if current_user.contractor? && @job_application.job.contractor_id == current_user.id
      if @job_application.update(job_application_params)
        redirect_to job_path(@job_application.job), notice: "Application status updated."
      else
        render :edit
      end
    else
      redirect_to jobs_path, alert: "Unauthorized action."
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
