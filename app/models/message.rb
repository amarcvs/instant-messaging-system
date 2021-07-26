class Message < ApplicationRecord
  belongs_to :messagewriter
  belongs_to :room
end
