class Shop < ActiveRecord::Base

  attr_accessible :shop_name, :shop_no
  #Relation
  has_many :locations
  has_many :genres
  has_many :publishers
  has_many :books
  #Validate
  validates :shop_no, :shop_name, :uniqueness => true
  validates :shop_no, :shop_name, :presence => true
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      shop = Shop.new(:shop_no => row[0], :shop_name => row[1])
      logger.debug "shop :#{shop.shop_no}"
      if Shop.find_by_shop_no_and_shop_name(shop.shop_no, shop.shop_name) == nil
      shop.save
      else
      end
    end
  end
end