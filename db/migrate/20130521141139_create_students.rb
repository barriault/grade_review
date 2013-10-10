class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :term_id
      t.string :initial_status
      t.string :final_status
      t.string :degree_candidate
      t.string :uin
      t.string :major
      t.string :classification
      t.string :last_name
      t.string :first_name
      t.string :cum_overall_gpa_hrs
      t.string :cum_institution_gpa
      t.integer :var_cum_qpts
      t.integer :var_term_qpts
      t.string :term_institution_gpa_hrs
      t.string :term_institution_gpa
      t.string :first_term
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :phone_number
      t.string :email
      t.boolean :emailed, :default => false

      t.timestamps
    end
  end
end
