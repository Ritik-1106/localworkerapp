class JobsController < ApplicationController
  before_action :set_job, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    # debugger
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
  def my_jobs
    @jobs = current_user.jobs.includes(:category)
    apply_filters # Apply the search filters to the contractor's jobs
  end

  def worker_all_jobs
    @jobs = Job.all.includes(:category)
    apply_filters
  end




  private
  def set_job
    Rails.logger.debug "Job ID: #{params[:id]}"  # Add this line to see the job id in logs
    @job = Job.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to jobs_path, alert: "Job not found."
  end

  def job_params
    params.require(:job).permit(:name, :description, :salary, :location, :category_id, :vacancies)
  end

  def apply_filters
        # Apply filters from the search bar if provided
        if params[:query].present?
          search_query = "%#{params[:query]}%"

          # Check if the input contains only numbers for salary filtering
          if params[:query].match(/\A\d+\z/)
            salary_value = params[:query].to_i
            # Filter jobs with salary greater than or equal to the entered value
            @jobs = @jobs.where("jobs.salary >= ?", salary_value)
          else
            # Filter by job name, location, or category name if it's not a number
            @jobs = @jobs.joins(:category)
                         .where("jobs.name LIKE :query OR jobs.location LIKE :query OR categories.name LIKE :query", query: search_query)
          end
        end
  end
end
