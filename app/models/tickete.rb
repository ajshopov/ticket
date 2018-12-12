class Tickete < ApplicationRecord
  belongs_to :project
<<<<<<< HEAD
    validates :name, presence: true
    validates :description, presence: true, length: { minimum: 10 }
=======
>>>>>>> ac7ebfe523d6c345f08406ce98e37402ba743581
end
