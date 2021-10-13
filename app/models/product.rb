class Product < ApplicationRecord

	
	belongs_to :user

	# paginates_per_page 3

	validates :title, presence: true, length: {minimum: 2}
	validates :description, presence: true, length: { minimum: 3}
	validates :price, presence: true

	mount_uploader :image, AvatarUploader

end
