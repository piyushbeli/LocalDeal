Category.create!([
  {name: "Food", slug: "food" , 'image-url': 'https://s3-us-west-2.amazonaws.com/paylo-images/images/categories/food.jpg'},
  {name: "Beauty and Wellness", slug: "beauty-and-wellness", 'image-url': 'https://s3-us-west-2.amazonaws.com/paylo-images/images/categories/spa+and+saloon.jpg'},
  {name: "Travel", slug: "travel", 'image-url': 'https://s3-us-west-2.amazonaws.com/paylo-images/images/categories/outdoor.jpg'},
])
FriendlyId::Slug.create!([
  {slug: "food", sluggable_id: 1, sluggable_type: "Category", scope: nil},
  {slug: "beauty-and-wellness", sluggable_id: 2, sluggable_type: "Category", scope: nil},
  {slug: "travel", sluggable_id: 3, sluggable_type: "Category", scope: nil},
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
