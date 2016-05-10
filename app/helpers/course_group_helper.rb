module CourseGroupHelper

  def weekdays_select
    (0..6).map { |k| [t("date.day_names")[k], k] }
  end

  def group_types_select
    CourseGroup::GROUP_TYPES.map { |k| [I18n.t("course_groups.group_types.#{k}"), k]}
  end

  def registration_button(course_group)
    if current_user.enrolled?(course_group)
      link_to t('.deregistrate'), deregistrate_subject_course_group_path(subject_id: course_group.subject.id, id: course_group.id), class: 'btn btn-info pull-right'
    else
      link_to t('.registrate'), registrate_subject_course_group_path(subject_id: course_group.subject.id, id: course_group.id), class: 'btn btn-info pull-right'
    end
  end

  def group_class(type)
    if ['class', 'laboratory'].include?(type)
      'panel-success'
    else
      'panel-info'
    end
  end

end