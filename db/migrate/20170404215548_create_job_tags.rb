class CreateJobTags < ActiveRecord::Migration
  def change
    create_table :job_tags do |t|
      t.references :tag, index: true, foreign_key: true
      t.references :job, index: true, foreign_key: true

      t.timestamps null:false
    end
  end
end
