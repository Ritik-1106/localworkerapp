# app/mailers/job_application_mailer.rb
class JobApplicationMailer < ApplicationMailer
  default from: "notifications@example.com"

  def accepted_email
    @application = params[:application]
    @worker = @application.worker
    @job = @application.job
    mail(to: @worker.email, subject: "Job Application Accepted")
  end

  def rejected_email
    @application = params[:application]
    @worker = @application.worker
    @job = @application.job
    mail(to: @worker.email, subject: "Job Application Rejected")
  end
end
