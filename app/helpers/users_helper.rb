module UsersHelper

  def role_types_select
    User::ROLES.map { |k| [I18n.t("users.roles.#{k}"), k]}
  end
end
