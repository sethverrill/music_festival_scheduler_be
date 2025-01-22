User.destroy_all
Venue.destroy_all
Artist.destroy_all
Schedule.destroy_all


users = User.create!([
  { first_name: "Zinia",  last_name: "Turington", email: "ledbyzed@zune.com" },
  { first_name: "Drew", last_name: "Zapato, Jr.", email: "drewskishoeskitwoski@orbitz.org" },
  { first_name: "Norma", last_name: "Cloghorne", email: "plainbrasstaps@chewy.edu" },
  { first_name: "Kilgore", last_name: "Trout", email: "itgoesandso@aol.com" }
])

venues = Venue.create!([
  { name: "The Double Deuce" },
  { name: "The Gaslight Cafe" },
  { name: "Death Star Cantina" },
  { name: "Buster's Biker Bar" }
])

artists = Artist.create!([
  { name: "Stillwater" },
  { name: "The Wonders" },
  { name: "The Soggy Bottom Boys" },
  { name: "The Beets" },
  { name: "Steel Dragon" },
  { name: "Mouse Rat" },
  { name: "Infinite Sorrow" },
  { name: "The Dewey Cox Band" },
  { name: "Dr. Teeth and The Electric Mayhem" },
  { name: "Jem and the Holograms" },
  { name: "The Rutles" },
  { name: "Scrantonicity" },
  { name: "Hedwig and the Angry Inch" },
  { name: "Ziggy Stardust and the Spiders from Mars" },
  { name: "Crucial Taunt" },
  { name: "Fiona and the Firecats" }
])

schedules = users.map { |user| Schedule.create!(user: user) }
time_slots = (1..8).to_a

venues.each_with_index do |venue, venue_index|
  filled_slots = 0
  time_slots.each do |slot|
    break if filled_slots == 4

    next if slot.odd? && venue_index.odd?

    artist = artists.shift

    show = Show.create!(
      time_slot: slot,
      venue: venue,
      artist: artist
    )

    schedule = schedules.sample
    ScheduleShow.create!(
      schedule: schedule,
      show: show
    )

    filled_slots += 1
  end
end