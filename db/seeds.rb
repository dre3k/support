MEMBER_PASSWORD = 'member'
MEMBERS_COUNT = 10
begin
  MEMBERS_COUNT.times do |i|
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

begin
  60.times do
    t = Ticket.create!({
      name: Faker::Name.name,
      email: Faker::Internet.email,
      department: Faker::Job.title,
      subject: Faker::Job.title,
      message: Faker::Lorem.paragraph
    })

    if rand(2).zero?
      t.add_reply({
        owner_to_id: rand(MEMBERS_COUNT),
        status_to_id: 1,
        message: Faker::Lorem.paragraph
      })
    end
  end
rescue
  puts 'Looks like Tickets already been seeded'
end
