class SemesterJoiner
  attr_accessor :semester

  def initialize(semester)
    @semester = semester
  end

  def join(users)
    [*users].each do |user|
      user.semesters << semester unless user.semesters.include?(semester)
    end
  end

  def leave(users)
    [*users].each do |user|
      user.semesters.delete(semester) if user.semesters.include?(semester)
    end
  end
end
