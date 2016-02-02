class User < ActiveRecord::Base
  has_many :orders, :class_name => 'Order'
  has_many :deliveries, :class_name => 'Order'

  validates :username, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :address, presence: true
  validates :email, presence: true

  def self.update_user_rating(id)
    user = User.find(id)
    user.rating = Order.where('deliverer_id = ?', id).average(:rating).to_i
    user.save
  end

end