class Genre < ActiveRecord::Base
  belongs_to :shop
  has_many :books
  attr_accessible :genre_name, :shop_id
  validates :genre_name, :presence => true
  validates_uniqueness_of :genre_name, scope: :shop_id
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      shop = Shop.find_by_shop_no(row[1])
      logger.debug "shop :#{shop.id}"
      genre = Genre.new(:genre_name => row[0], :shop_id => shop.id)
      logger.debug "genre :#{genre.genre_name}"
      if Genre.find_by_genre_name_and_shop_id(genre.genre_name, genre.shop_id) == nil
      genre.save
      else
      end
    end
  end
end
