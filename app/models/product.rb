class Product < ActiveRecord::Base
  belongs_to :company
  belongs_to :group
  has_many :photos
  belongs_to :price
end