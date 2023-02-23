class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates_presence_of :message
  # after_create_commit { broadcast_append_to :chats }
end
