module StudentsHelper
  
  def student_final_status_form_column(record, html_options)
    selected = record.final_status
    options = { :selected => selected, :include_blank => as_(:_select_) }
    
    if Term.current.is_summer?
      select_options = ["SAIL Good Standing", "SAIL Probation", "SAIL Suspension"]
    else
      if record.initial_status.eql?("Probation")
        select_options = ["Probation", "Departmental Suspension", "Remove"]
      else
        select_options = ["Probation", "Suspension"]
      end
    end
    
    select(:record, :final_status, select_options, options, html_options)
  end
  
end