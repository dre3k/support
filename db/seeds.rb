10.times do |i|
  Customer.create!(name: "Demo_#{i}", email: "demo_#{i}@demo.com")
end
