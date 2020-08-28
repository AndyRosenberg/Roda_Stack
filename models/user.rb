class User < ActiveRecord::Base
  validates :name, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 7 }

  before_create :hash_password
  before_update :hash_password, if: :password_has_changed
  attr_accessor :password_has_changed

  def hash_password
    self.password = Argon2::Password.create(password)
  end

  def authenticate(pw_param)
    Argon2::Password.verify_password(pw_param, password)
  end
end