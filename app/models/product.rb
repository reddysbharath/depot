class Product < ActiveRecord::Base
validates :title , presence: true , uniqueness: true
validates :description , presence: true
validates :price, numericality: {greater_than_or_equal_to: 0.01}
has_many :line_items
before_destroy :ensure_not_referenced_by_any_line_item
end
def self.latest
	Product.order(:updated_at).last
end

private
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base , 'Line items present')
			return false
		end
	end