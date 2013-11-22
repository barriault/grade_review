class AddRecommendedAppealStatusToStudents < ActiveRecord::Migration
  def change
    add_column :students, :recommended_appeal_status, :string
  end
end
