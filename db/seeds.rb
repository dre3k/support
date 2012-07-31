10.times do |i|
  Customer.create!(name: "Demo_#{i}", email: "demo_#{i}@demo.com")
end

MEMBER_PASSWORD = 'member'
10.times do |i|
  Member.create!(
    username: "member_#{i}",
    password: MEMBER_PASSWORD,
    password_confirmation: MEMBER_PASSWORD
  )
end
