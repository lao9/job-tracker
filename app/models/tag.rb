class Tag < ActiveRecord::Base
  validates :title, presence: true

  has_many :job_tags
  has_many :jobs, through: :job_tags

  def job_count
    jobs.count
  end

  def jobs_sorted_by_tag_count
    Job.joins(:tags).group("jobs.id").order(("count(jobs.id) DESC"))
  end

end
