class User < ApplicationRecord
  has_secure_password

  has_many :appearances

  has_many :guests, through: :appearances
  has_many :episodes, through: :appearances


end
