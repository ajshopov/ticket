class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
end
