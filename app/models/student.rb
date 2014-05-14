class Student < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :classification, :cum_institution_gpa, :cum_overall_gpa_hrs, :degree_candidate, 
    :email, :emailed, :first_name, :first_term, :last_name, :major, :phone_number, :postal_code, :state, :term_institution_gpa, 
    :term_institution_gpa_hrs, :uin, :var_cum_qpts, :var_term_qpts, :initial_status, :final_status, :term, :admit_type, :admit_status
    
  belongs_to :term
  
  default_scope { where(term_id: Term.current.id) }
  
  def to_label
    "#{first_name} #{last_name} [#{uin}] - #{initial_status}"
  end
  
  def ap_type
    admit_type if admit_status.eql?("AP")
  end
  
  def send_email
    case final_status
    when "Probation"
      LetterMailer.probation(self).deliver
    when "Suspension"
      LetterMailer.suspension(self).deliver
    when "Departmental Suspension"
      LetterMailer.departmental_suspension(self).deliver
    when "SAIL Good Standing"
      LetterMailer.sail_good_standing(self).deliver
    when "SAIL Probation"
      LetterMailer.sail_probation(self).deliver
    when "SAIL Suspension"
      LetterMailer.sail_suspension(self).deliver
    end
  end
  
  def final_status_select_options
    if term.is_summer?
      ["SAIL Good Standing", "SAIL Probation", "SAIL Suspension"]
    else
      initial_status.eql?("Probation") ? ["Probation", "Departmental Suspension", "Remove"] : ["Probation", "Suspension", "Departmental Suspension"]
    end
  end
  
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      student = new
      student.attributes = row.to_hash.slice(*accessible_attributes)
      student.term = Term.current
      student.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
  
  def self.merge_data(options = {})
    CSV.generate(options) do |csv|
      csv << ["UIN", "Major", "Class", "Last Name", "First Name", "Address 1", "Address 2", "City", "State", "Postal Code"]

      all.each do |student|
        csv << [student.uin, student.major, student.classification, student.last_name, student.first_name, student.address_1, 
          student.address_2, student.city, student.state, student.postal_code]
      end
    end
  end
  
  def self.alpha_roster(options = {})
    CSV.generate(options) do |csv|
      csv << ["UIN", "Last Name", "First Name", "Initial Status", "Final Status", "Appeal Status", "Major", "Class", "Cum OA GPA Hrs", 
        "Cum Instn GPA", "Var Cum Qpts", "Var Term Qpts", "Term Instn GPA Hrs", "Term Instn GPA", "AS", "AT"]
      
      all.each do |student|
        csv << [student.uin, student.last_name, student.first_name, student.initial_status, student.final_status, student.appeal_status,
          student.major, student.classification, student.cum_overall_gpa_hrs, student.cum_institution_gpa, student.var_cum_qpts,
          student.var_term_qpts, student.term_institution_gpa_hrs, student.term_institution_gpa, student.admit_status, student.admit_type]
      end
    end
  end
  
  def self.standard_report(options = {})
    CSV.generate(options) do |csv|
      csv << ["Final Status", "Recom'd Appeal Status", "Appeal Status", "UIN", "Major", "Class", "Last Name", "First Name"]
      
      all.each do |student|
        csv << [student.final_status, student.recommended_appeal_status, student.appeal_status, student.uin, student.major, 
          student.classification, student.last_name, student.first_name]
      end
    end
  end
  
end
