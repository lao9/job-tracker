class Job < ActiveRecord::Base
  validates :title, :level_of_interest, :city, presence: true
  validates :category, presence: true

  belongs_to :company
  belongs_to :category
  has_many :comments

  has_many :job_tags
  has_many :tags, through: :job_tags

  def self.count_by_interest
    Job.group(:level_of_interest).count.sort_by(&:first).reverse
  end

  def self.top_three_by_average_interest
    avg_sorted_list = Job.group(:company).average(:level_of_interest).sort_by(&:last)
    if avg_sorted_list.count < 3
      avg_sorted_list.reverse
    else
      avg_sorted_list[-3..-1].reverse
    end
  end

  def self.count_by_city
    Job.group(:city).count.sort_by(&:last).reverse
  end

  def tags_sorted_by_tag_count
    Tag.joins(:jobs).group("tags.id").order(("count(tags.id) DESC"))
  end

end
