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
