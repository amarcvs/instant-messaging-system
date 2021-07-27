class Messagewriter < ApplicationRecord
    validates_uniqueness_of :username

    def self.generate
        number = rand.to_s[2..4]
        username = "User-#{number}"
        create(username: username)
      end
end
