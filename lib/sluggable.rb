# module Sluggable
# 	extend ActiveSupport::Concern

# 	included do
# 		before_create :generate_slug
# 		class_attribute :slug_column
# 	end

# 	def generate_slug
# 		self.slug = self.slug_column.gsub(/[\s\/\.\?\\]/, "-").downcase
# 	end

# 	def to_param
# 		self.slug
# 	end

# 	module ClassMethods
# 		def sluggable_column (column_name)
# 			self.slug_column = column_name
# 		end
# 	end
# end