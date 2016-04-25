module CourseGroupHelper

  def weekdays_select
    (0..6).map { |k| [t("date.day_names")[k], k] }
  end

  def group_types_select
    CourseGroup::GROUP_TYPES.map { |k| [I18n.t("course_groups.group_types.#{k}"), k]}
  end

  def group_class(type)
    if ['class', 'laboratory'].include?(type)
      'panel-success'
    else
      'panel-info'
    end
  end

end