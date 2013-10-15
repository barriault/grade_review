class MailPreview < MailView
  
  def probation
    student = get_student
    mail = LetterMailer.probation(student)
  end
  
  def departmental_suspension
    student = get_student
    mail = LetterMailer.departmental_suspension(student)
  end
  
  def suspension
    student = get_student
    mail = LetterMailer.suspension(student)
  end
  
  def sail_good_standing
    student = get_student
    mail = LetterMailer.sail_good_standing(student)
  end
  
  def sail_probation
    student = get_student
    mail = LetterMailer.sail_probation(student)
  end
  
  def sail_suspension
    student = get_student
    mail = LetterMailer.sail_suspension(student)
  end
  
private
  
  def get_student
    student = Struct.new(:term, :uin, :major, :email, :first_name, :last_name, :address_1, :address_2, :city, :state, :postal_code)
      .new(Term.current, '123004567', 'MARB', 'thomas.jefferson@tamug.edu', 'Thomas', 'Jefferson', '931 Thomas Jefferson Parkway', nil, 'Charlottesville', 'VA', '22902')
  end
end