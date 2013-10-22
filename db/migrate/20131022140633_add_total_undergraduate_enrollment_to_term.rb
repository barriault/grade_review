class AddTotalUndergraduateEnrollmentToTerm < ActiveRecord::Migration
  def change
    add_column :terms, :total_undergraduate_enrollment, :integer
  end
end
