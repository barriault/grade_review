class AddAdmitStatusAndAdmitTypeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :admit_status, :string
    add_column :students, :admit_type, :string
  end
end
