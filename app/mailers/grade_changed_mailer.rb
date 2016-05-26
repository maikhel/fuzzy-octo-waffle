class GradeChangedMailer < NotificationMailer

  def notify(grade_id)
    @grade = Grade.find grade_id
    @subject = @grade.course_group.subject
    user = @grade.user
    mail(to: user.email, subject: I18n.t('grade_changed_mailer.subject'))
  end

end