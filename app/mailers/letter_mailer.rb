class LetterMailer < ActionMailer::Base
  
  # The donotreply@tamug.edu account does not allow me to send from Donna's account.
  # default from: "Donna C. Lang <langd@tamug.edu>"
  default from: "donotreply@tamug.edu"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.letter_mailer.test.subject
  #
  def probation(student)
    @student = student
    mail to: student.email, subject: "Probation"
  end
    
  def probation_level_1(student)
    @student = student
    mail to: student.email, subject: "Probation"
  end
  
  def probation_level_2(student)
    @student = student
    mail to: student.email, subject: "Probation"
  end
  
  def suspension(student)
    @student = student
    mail to: student.email, subject: "Suspension"
  end
  
  def departmental_suspension(student)
    @student = student
    mail to: student.email, subject: "Departmental Suspension"
  end
  
  def campus_suspension(student)
    @student = student
    mail to: student.email, subject: "Campus Suspension"
  end
  
  def sail_good_standing(student)
    @student = student
    mail to: student.email, subject: "SAIL Congratulations!"
  end
  
  def sail_probation(student)
    @student = student
    mail to: student.email, subject: "SAIL Probation"
  end
  
  def sail_suspension(student)
    @student = student
    mail to: student.email, subject: "SAIL Suspension"
  end
  
  def gateway_good_standing(student)
    @student = student
    mail to: student.email, subject: "Gateway Congratulations!"
  end
  
  def gateway_probation(student)
    @student = student
    mail to: student.email, subject: "Gateway Probation"
  end
  
  def gateway_suspension(student)
    @student = student
    mail to: student.email, subject: "Gateway Suspension"
  end
end
