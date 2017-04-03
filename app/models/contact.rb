class Contact < ActiveRecord::Base
  validates :name, :position, :email, presence: true

  belongs_to :company
end
