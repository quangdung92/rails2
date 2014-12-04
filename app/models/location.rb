class Location < ActiveRecord::Base
  belongs_to :shop
  has_many :books
  attr_accessible :location_name, :shop_id
  validates :location_name, :presence => true
  validates_uniqueness_of :location_name, scope: :shop_id
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      shop = Shop.find_by_shop_no(row[1])
      logger.debug "shop :#{shop.id}"
      location = Location.new(:location_name => row[0], :shop_id => shop.id)
      logger.debug "location :#{location.shop_id}"
      if Location.find_by_location_name_and_shop_id(location.location_name, location.shop_id) == nil
      location.save
      else
      end
    end
  end
end
