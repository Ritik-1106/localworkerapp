class JobApplicationsController < ApplicationController
  before_action :set_job, only: [ :new, :create, :total_applicants, :edit, :update ] # Include :update here
  before_action :set_job_application, only: [ :show, :edit, :update ]

  # GET /jobs/:job_id/job_applications/new
  def new
    @job_application = @job.job_applications.new
  end

  # POST /jobs/:job_id/job_applications
  def create
    @job_application = @job.job_applications.new(job_application_params)
    @job_application.worker_id = current_user.id # Set worker_id automatically

    if @job_application.save
      redirect_to @job, notice: "Job application was successfully created."
    else
      render :new
    end
  end

  # GET /jobs/:job_id/applicants
  def total_applicants
    if current_user.contractor?
      @applicants = @job.job_applications
    else
      redirect_to jobs_path, alert: "You do not have permission to view this page."
    end
  end

  # GET /job_applications/my_applications
  def my_applications
    @my_applications = current_user.job_applications
    @jobs = Job.where(id: @my_applications.pluck(:job_id))
  end

  # GET /jobs/:job_id/job_applications/:id
  def show
    @job = Job.find_by(id: params[:job_id])
    if @job.nil?
      redirect_to jobs_path, alert: "Job not found."
    elsif current_user.contractor?
      @applicants = @job.job_applications
    else
      redirect_to jobs_path, alert: "You do not have permission to view this page."
    end
  end


  # GET /jobs/:job_id/job_applications/:id/edit
  def edit
    if current_user.contractor?
      @job_application = JobApplication.find(params[:id])
      @job = @job_application.job
    else
      redirect_to jobs_path, alert: "You do not have permission to edit this application."
    end
  end




  # PATCH /jobs/:job_id/job_applications/:id
  def update
    if current_user.contractor?
      if @job_application.update(job_application_params)
        # Send email based on status if status is updated
        if @job_application.status == "Accepted"
          JobApplicationMailer.with(application: @job_application).accepted_email.deliver_now
        elsif @job_application.status == "Rejected"
          JobApplicationMailer.with(application: @job_application).rejected_email.deliver_now
        end
        redirect_to total_applicants_job_job_applications_path(@job_application.job, @job_application), notice: "Job application was successfully updated."
      else
        render :edit, alert: "Unable to update the job application."
      end
    else
      redirect_to jobs_path, alert: "You do not have permission to update this application."
    end
  end


  private

  def job_application_params
    params.require(:job_application).permit(:description, :softskills, :expected_salary, :status)
  end

  def set_job
    @job = Job.find_by(id: params[:job_id])
    redirect_to jobs_path, alert: "Job not found." if @job.nil?
  end

  def set_job_application
    @job_application = JobApplication.find(params[:id])
  end
end
