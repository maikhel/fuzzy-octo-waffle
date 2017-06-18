module CourseGroupHelper
  def weekdays_select
    (0..6).map { |k| [t('date.day_names')[k], k] }
  end

  def group_types_select
    CourseGroup::GROUP_TYPES.map { |k| [I18n.t("course_groups.group_types.#{k}"), k] }
  end

  def time_periods_select
    time_periods.each_with_index.map { |val, key| [val, key] }
  end

  def time_periods
    ['8.00 - 9.30', '9.45 - 11.15', '11.30 - 13.00', '13.15 - 14.45', '15.00 - 16.30', '16.45 - 18.15', '18.30 - 20.00']
  end

  def registration_button(course_group)
    if current_user.enrolled?(course_group)
      link_to(
        t('.deregistrate'),
        deregistrate_subject_course_group_path(subject_id: course_group.subject.id, id: course_group.id),
        method: 'POST',
        class: 'btn btn-info pull-right'
      )
    else
      link_to(
        t('.registrate'),
        registrate_subject_course_group_path(subject_id: course_group.subject.id, id: course_group.id),
        method: 'POST',
        class: 'btn btn-info pull-right'
      )
    end
  end

  def danger_class(val)
    'danger' if val == 2
  end

  def group_class(type)
    if %w[class laboratory].include?(type)
      'panel-success'
    else
      'panel-info'
    end
  end

  def table_group_class(type)
    if %w[class laboratory].include?(type)
      'success'
    else
      'info'
    end
  end
end
