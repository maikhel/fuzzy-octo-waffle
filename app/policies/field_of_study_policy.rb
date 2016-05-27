class FieldOfStudyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.staff?
        scope.all
      else
        if user.partner and (user.partner != Partner.default)
          user_companies_scope = user.companies.count  > 0 ? "companies.id IN (#{user.companies.map(&:id).join(",")}) OR" : ""
          scope.where("#{user_companies_scope} partner_id = #{user.partner_id}")
        else
          scope.where(id: user.companies)
        end
      end
    end
  end

end