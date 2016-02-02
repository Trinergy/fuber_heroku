class Order < ActiveRecord::Base
  belongs_to :orderer, :class_name => 'User'
  belongs_to :deliverer, :class_name => 'User'

  validates :delivery_status, numericality: { only_integer: true,
                                              maximum: 3,
                                              minimum: 1}
  validates :cuisine, presence: true
  validates :destination, presence: true
  validates :price, numericality: { only_integer: true }
  
  # validate :delivery_date_cannot_be_in_the_past

  # def delivery_date_cannot_be_in_the_past
  #   errors.add(:delivery_date, "can't be in the past") if
  #     !delivery_date.blank? and delivery_date < Date.today
  # end

  def self.process_delivery(order_id, deliverer_id)
    order = find(order_id)
    order.deliverer_id = deliverer_id
    order.delivery_status = 2
    order.save
  end

  def self.orderer_history(id)
    Order.where('orderer_id = ?', id).where('delivery_status = 3').order(created_at: :desc)
  end

  def self.deliverer_history(id)
    Order.where('deliverer_id = ?', id).where('delivery_status = 3').order(created_at: :desc)
  end

  def self.user_pending_orders(id)
    Order.where('orderer_id = ?', id).where('delivery_status = 1').order(created_at: :desc)
  end

  def self.not_user_pending_orders(id)
    Order.where('orderer_id != ?', id).where('delivery_status = 1').order(created_at: :desc)
  end

  def self.being_delivered_orders(id)
    Order.where('orderer_id =?', id).where('delivery_status = 2').order(created_at: :desc)
  end

  def self.pending_deliveries(id)
    Order.where('deliverer_id =?', id).where('delivery_status = 2').order(created_at: :desc)
  end
end