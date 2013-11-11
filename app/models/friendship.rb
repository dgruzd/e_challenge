class Friendship < ActiveRecord::Base
  belongs_to :member
  belongs_to :friend, class_name: 'Member'

  validate :check_ids

  private
  def check_ids
    errors.add(:member_id, 'wrong order of ids') unless member_id < friend_id
  end
end
