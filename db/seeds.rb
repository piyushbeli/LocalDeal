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
  {name: "FIXED_PERCENT", description: "Flat percentage doscount on total bill"},
  {name: "SPECIAL_DISCOUNTED_PRICE", description: "Special customized price instead of actual cost"}
])
Subcategory.create!([
  {name: "Indian", category_id: 1, slug: "indian"},
  {name: "Italian", category_id: 1, slug: "italian"},
  {name: "Saloon", category_id: 2, slug: "saloon"},
  {name: "Spa", category_id: 2, slug: "spa"}
])
