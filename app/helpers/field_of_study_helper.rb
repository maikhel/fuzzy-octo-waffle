module FieldOfStudyHelper

  def mode_types_select
    FieldOfStudy::MODE_TYPES.map { |k| [I18n.t("field_of_studies.mode_types.#{k}"), k]}
  end

  def degree_types_select
    FieldOfStudy::DEGREE_TYPES.map { |k| [I18n.t("field_of_studies.degree_types.#{k}"), k]}
  end
end