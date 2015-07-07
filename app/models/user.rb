class User < ActiveRecord::Base
  before_save {
    self.email = email.downcase
  }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #has a valid username, with a max length of 255 chars, no spaces, and case sensitivity is irrelevant when checking for uniques
  validates :name, presence: true, length: {maximum: 255}, format: {without: /\s/}, uniqueness: {case_sensitive: false}
  validates :email, presence: true, length: {maximum: 255}, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  #some black magic black box function, i have no idea how this works.
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

end
