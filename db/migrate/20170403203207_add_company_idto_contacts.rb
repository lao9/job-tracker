class AddCompanyIdtoContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :company, index: true, foreign_key: true
  end
end
