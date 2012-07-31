MEMBER_PASSWORD = 'member'
begin
  10.times do |i|
    Member.create!(
      username: "member_#{i}",
      password: MEMBER_PASSWORD,
      password_confirmation: MEMBER_PASSWORD
    )
  end
rescue
  puts 'Looks like Members already been seeded'
end

begin
  TicketStatus::NAMES.each do |name|
    TicketStatus.create!(name: name)
  end
rescue
  puts 'Looks like TicketStatuses already been seeded'
end
