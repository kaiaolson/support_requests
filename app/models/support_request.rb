class SupportRequest < ActiveRecord::Base
  paginates_per 7
  validates :name, presence: true
  validates :email, presence: true

  def self.search(term)
    where("name || email || department || message ILIKE ?","%#{term}%")
  end
end
