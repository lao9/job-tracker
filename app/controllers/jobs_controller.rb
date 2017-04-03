class JobsController < ApplicationController
  before_action :job_selector, only: [:update, :destroy]

  def index
    @company = Company.find(params[:company_id])
    @jobs = @company.jobs
  end

  def new
    @company = Company.find(params[:company_id])
    @job = Job.new()
  end

  def create
    @company = Company.find(params[:company_id])
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
    @company = @job.company
  end

  def update
    @job.update(job_params)
    if @job.save
      flash[:success] = "#{@job.title} updated"
      redirect_to company_job_path(@job.company, @job)
    else
      render :edit
    end
  end

  def destroy
    @job.destroy

    flash[:sucess] = "#{@job.title} was successfully deleted!"
    redirect_to company_jobs_path
  end

  private

  def job_selector
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id)
  end
end
