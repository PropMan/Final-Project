class Issue < ActiveRecord::Base
	has_many :comments
	belongs_to :tenant
	belongs_to :category

	before_create :set_status_new
	before_save :check_if_done

	validates :category, presence: true

	def set_status_new
		self.status = :new
	end

	def check_if_done
		if self.status == 'done'
			self.complete_date = Time.now
		else
			self.complete_date = nil
		end
	end

	def duration
		if complete_date.nil?
			(Time.now - created_at).floor
		else
			(complete_date - created_at).floor
		end
	end

	# CONSTANTS
	def self.manager_statuses
		[:new, :pending]
	end
	def self.tenant_statuses
		[:pending, :done]
	end

end
