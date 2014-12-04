class Publisher < ActiveRecord::Base
  belongs_to :shop
  has_many :books
  attr_accessible :publisher_name, :shop_id
  validates :publisher_name, :presence => true
  validates_uniqueness_of :publisher_name, scope: :shop_id
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      shop = Shop.find_by_shop_no(row[1])
      logger.debug "shop :#{shop.id}"
      publisher = Publisher.new(:publisher_name => row[0], :shop_id => shop.id)
      logger.debug "publisher :#{publisher.publisher_name}"
      if Publisher.find_by_publisher_name_and_shop_id(publisher.publisher_name, publisher.shop_id) == nil
      publisher.save
      else
      end

    end
  end
end
