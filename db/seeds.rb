Vendor.create!([
  {tokens: {"dWcTOAiOjZZoASj0sGW0WA"=>{"token"=>"$2a$10$/a7tH6lyWOIFOtZtcDNsAuszJ2QDz4iKlLAcOZw5b7o8G6ABFnOoO", "expiry"=>1434350850, "last_token"=>"$2a$10$P3vE1P0f0WXfeJlLzrfbde6yS/Nxzplr0nhSQg3sRiUWBN4Ctd1sS", "updated_at"=>"2015-06-01T12:17:31.285+05:30"}}, provider: "email", uid: "piyush.beli+1@gmail.com", encrypted_password: "$2a$10$b4vfSsv8MSA9ZZhSHIAjoex3UbkVG5RSPWURpjco0xAlzQgBAF4TC", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-06-01 06:47:30", last_sign_in_at: "2015-06-01 06:47:30", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", confirmation_token: "7d3c13b82be73b73eb82ce0e57c69951881f5440f0f4484ce75b972367b6b93d", confirmed_at: "2015-06-01 06:46:59", confirmation_sent_at: "2015-06-01 06:46:59", unconfirmed_email: nil, name: "Dominos", nickname: nil, image: nil, email: "piyush.beli+1@gmail.com", mobile: "9928618166", website: nil, category_id: nil}
])
God.create!([
  {tokens: {}, provider: "email", uid: "piyush.beli@gmail.com", encrypted_password: "$2a$10$S6L..ouoml7xiwoq7iY9..y0E533ntkmMeLGltb0mA6k9QFbjyhAi", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, confirmation_token: "eeea4be885c065b7a5b170418a7af76bd2e1e35501588e4554b950339f29bd67", confirmed_at: nil, confirmation_sent_at: "2015-06-01 06:48:11", unconfirmed_email: nil, name: "Piyush Beli", nickname: nil, image: nil, email: "piyush.beli@gmail.com"}
])
Category.create!([
  {name: "Food", slug: "food"},
  {name: "Beauty and Wellness", slug: "beauty-and-wellness"},
  {name: "Travel", slug: "travel"},
  {name: "Grocery", slug: "grocery"}
])
FriendlyId::Slug.create!([
  {slug: "food", sluggable_id: 1, sluggable_type: "Category", scope: nil},
  {slug: "beauty-and-wellness", sluggable_id: 2, sluggable_type: "Category", scope: nil},
  {slug: "travel", sluggable_id: 3, sluggable_type: "Category", scope: nil},
  {slug: "grocery", sluggable_id: 4, sluggable_type: "Category", scope: nil}
])
OfferType.create!([
  {name: "PERCENT", description: "Flat percentage doscount on total bill"},
  {name: "FLAT_OFF", description: "Flat rupee doscount like 300 off on min bill of 600"},
  {name: "FLAT", description: "Fixed price for a fixed menu"}
])
Subcategory.create!([
  {name: "Indian", category_id: 1, slug: "indian"},
  {name: "Italian", category_id: 1, slug: "italian"},
  {name: "Saloon", category_id: 2, slug: "saloon"},
  {name: "Spa", category_id: 2, slug: "spa"}
])
