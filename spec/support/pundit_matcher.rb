RSpec::Matchers.define :pundit_permit do |action, *attributes|
  match do |policy|
    policy.public_send("#{action}?", *attributes)
  end

  failure_message do |policy|
    "#{policy.class} does not permit #{action} on #{policy.record} for #{policy.user.inspect}."
  end

  failure_message_when_negated do |policy|
    "#{policy.class} does not forbid #{action} on #{policy.record} for #{policy.user.inspect}."
  end
end
