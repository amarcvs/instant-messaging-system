class Room < ApplicationRecord
    has_many :messages, dependent: :destroy # dependent: :destroy ?
    has_many :messagewriters, through: :messages
end
