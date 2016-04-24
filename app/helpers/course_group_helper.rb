module CourseGroupHelper

  def weekdays_select
    (0..6).map { |k| [t("date.day_names")[k], k] }
  end

end