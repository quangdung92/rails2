class Book < ActiveRecord::Base
  belongs_to :location
  belongs_to :genre
  belongs_to :shop
  belongs_to :publisher
  attr_accessible :author, :book_name, :final_purchase, :final_sale,
                  :inventory_number, :jan, :nation_sale, :price, :sale_number,
                  :publisher_id, :shop_id, :genre_id, :location_id, :publish_date

  validates :book_name, :shop_id, :location_id, :publisher_id, :presence => true
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      shop = Shop.find_by_shop_no(row[8])
      location = Location.find_by_location_name_and_shop_id(row[0],shop.id)
      publisher = Publisher.find_by_publisher_name_and_shop_id(row[5], shop.id)
      genre = Genre.find_by_genre_name_and_shop_id(row[1],shop.id)
      if genre == nil
        @gen = nil
        logger.debug "nil"
      else
        @gen = genre.id
      end
      book = Book.create!(:book_name => row[3], :location_id => location.id,
                      :publisher_id => publisher.id, :shop_id => shop.id, :genre_id => @gen,
                      :jan =>row[2] ,:author => row[4], :publish_date => row[6], :price => row[7],:final_purchase => row[10],
                      :final_sale => row[11], :sale_number => row[12], :inventory_number => row[13], :nation_sale => row[14])
      logger.debug "genre :#{book.genre_id}"
      logger.debug "location :#{book.location_id}"
      logger.debug "shop :#{book.shop_id}"  
      logger.debug "name :#{book.book_name}"   
      logger.debug "jan :#{book.jan}"                                          
      logger.debug "price :#{book.price}"     
    end
  end
end
