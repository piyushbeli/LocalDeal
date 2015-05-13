God.create!([
  {tokens: {}, provider: "email", uid: "piyush.beli@gmail.com", password: "311404", encrypted_password: "$2a$10$S6L..ouoml7xiwoq7iY9..y0E533ntkmMeLGltb0mA6k9QFbjyhAi", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, confirmation_token: "6b06de2f36d47bc1f824a87d6efaba5ab90d1e6ec8a601b4d266a403085e257d", confirmed_at: nil, confirmation_sent_at: "2015-05-13 09:47:03", unconfirmed_email: nil, name: "Piyush Beli", nickname: nil, image: nil, email: "piyush.beli@gmail.com"}
])
Category.create!([
  {name: "Food"},
  {name: "Beauty and Wellness"},
  {name: "Travel"},
  {name: "Grocery"}
])
Subcategory.create!([
 {name: "Indian", category_id: 1},
 {name: "Italian", category_id: 1},
 {name: "Saloon", category_id: 2},
 {name: "Spa", category_id: 2},
])
