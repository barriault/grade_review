class AdminStudent < ActiveRecord::Base
  self.table_name = "students"
  
  attr_accessible :address_1, :address_2, :city, :classification, :cum_institution_gpa, :cum_overall_gpa_hrs, :degree_candidate, 
    :email, :emailed, :first_name, :first_term, :last_name, :major, :phone_number, :postal_code, :state, :term_institution_gpa, 
    :term_institution_gpa_hrs, :uin, :var_cum_qpts, :var_term_qpts, :initial_status, :final_status, :appeal_status, :term
    
  belongs_to :term
  
  default_scope { where(term_id: Term.current.id) }
  
  def to_label
    "#{first_name} #{last_name} [#{uin}]"
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

end