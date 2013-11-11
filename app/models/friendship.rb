class Friendship < ActiveRecord::Base
  belongs_to :member
  belongs_to :friend, class_name: 'Member'

  validate :check_ids

  after_create :update_counter_cache
  after_destroy :update_counter_cache

  private
  def check_ids
    errors.add(:member_id, 'wrong order of ids') unless member_id < friend_id
  end

  def update_counter_cache
    if self.destroyed?
      [member_id, friend_id].each do |i|
        Member.decrement_counter(:friends_count, i)
      end
    else
      [member_id, friend_id].each do |i|
        Member.increment_counter(:friends_count, i)
      end
    end
  end
end
