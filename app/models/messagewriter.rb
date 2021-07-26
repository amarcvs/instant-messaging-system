class Messagewriter < ApplicationRecord
    validates_uniqueness_of :username
end
