class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  include Spammable
  include Spammer
  include FriendlyId
  ratyrate_rater
  acts_as_marker
  markable_as :following
  friendly_id :slug_candidates, use: [:slugged, :history]

  devise :timeoutable, :timeout_in => 30.days
  validates :name, presence: true, allow_blank: false
  validates :mobile, length: {is: 10}, numericality: {only_integer: true}, uniqueness: true, allow_nil: true

  after_create :generate_slug

  has_many :comments, as: :commentator
  has_many :outlet_images, as: :uploader
  has_many :orders

  def as_json(options={})
    super(options.merge(
              except: [:created_at, updated_at],
              include: {
                  favorite_categories: {

                  }
              }
          ))
  end


  def alreadyBoughtTheOffer? (offer)
    user_offer = orders.select { |order| order.offer_id == offer.id}
    !user_offer.blank?
  end

  def isProfileComplete?
    !(email.blank? || mobile.blank? || name.blank?)
  end

  #In case of omniauth signup it won't generate the slug id
  def generate_slug
    self.save
  end

  #Slug candidate in sequence of priority
  def slug_candidates
    [
        "#{name}"
    ]
  end

  def user_comments
    self.comments.select do |comment|
      comment.commentable_type == 'Outlet'
    end
  end

  def user_replies
    self.comments.filter do |comment|
      comment.commentable_type == 'Comment'
    end
  end

end
