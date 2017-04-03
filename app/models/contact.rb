class Contact < ActiveRecord::Base
  validates :name, :position, :email, presence: true

end
