MEMBER_PASSWORD = 'member'
MEMBERS_COUNT = 10
begin
  MEMBERS_COUNT.times do |i|
    Member.create!(
      name:     Faker::Name.name,
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
  80.times do
    t = Ticket.create!({
      name: Faker::Name.name,
      email: Faker::Internet.email,
      department: Faker::Job.title,
      subject: Faker::Job.title,
      message: Faker::Lorem.paragraph
    })

    case r = rand(3)
    when 0
      # regular reply: status -> waiting for customer
      t.add_reply({
        replier_id:  rand(MEMBERS_COUNT),
        owner_to_id: rand(MEMBERS_COUNT),
        status_to_id: TicketStatus::SYMBOLS[:customer],
        message: Faker::Lorem.paragraph
      })
    when 1
      case r = rand(4)
      when 0
        # cancel reply
        t.add_reply({
          replier_id:  rand(MEMBERS_COUNT),
          status_to_id: TicketStatus::SYMBOLS[:cancelled],
          message: Faker::Lorem.paragraph
        })
      when 1
        # complete reply
        t.add_reply({
          replier_id:  rand(MEMBERS_COUNT),
          status_to_id: TicketStatus::SYMBOLS[:completed],
          message: Faker::Lorem.paragraph
        })
      when 2
        # onhold reply
        t.add_reply({
          replier_id:  rand(MEMBERS_COUNT),
          status_to_id: TicketStatus::SYMBOLS[:onhold],
          message: Faker::Lorem.paragraph
        })
      end
    end
  end
rescue
  puts 'Looks like Tickets already been seeded'
end
