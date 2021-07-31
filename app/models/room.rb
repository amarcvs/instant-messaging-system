class Room < ApplicationRecord
    has_many :messages
    has_many :messagewriters, through: :messages
end
