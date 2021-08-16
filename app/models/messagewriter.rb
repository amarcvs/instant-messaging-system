class Messagewriter < ApplicationRecord
    # validates_uniqueness_of :username

    def self.generate(user)
      username = user.email
      create(username: username)
    end
end
