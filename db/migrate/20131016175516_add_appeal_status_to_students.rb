class AddAppealStatusToStudents < ActiveRecord::Migration
  def change
    add_column :students, :appeal_status, :string
    add_index :students, :appeal_status
  end
end
