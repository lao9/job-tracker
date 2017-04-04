class Tag < ActiveRecord::Base
  validates :title, presence: true

  has_many :job_tags
  has_many :jobs, through: :job_tags
end
