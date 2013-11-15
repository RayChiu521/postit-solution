class Vote < ActiveRecord::Base

	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
	belongs_to :voteable, polymorphic: true

	validates :creator, uniqueness: { scope: [:voteable_type, :voteable_id] }


	def self.total_votes (obj)
		Vote.up_votes(obj) - Vote.down_votes(obj)
	end

	def self.up_votes (obj)
		Vote.where(voteable_type: obj.class.name, voteable_id: obj.id, vote: true).size
	end

	def self.down_votes (obj)
		Vote.where(voteable_type: obj.class.name, voteable_id: obj.id, vote: false).size
	end
end