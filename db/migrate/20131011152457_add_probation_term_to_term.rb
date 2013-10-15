class AddProbationTermToTerm < ActiveRecord::Migration
  def change
    add_column :terms, :probation_term, :string
  end
end
