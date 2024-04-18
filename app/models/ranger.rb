class Ranger < ApplicationRecord
  has_secure_password
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze
  UPPERCASE_FORMAT = /[A-Z]/.freeze
  LOWERCASE_FORMAT = /[a-z]/.freeze
  SPECIAL_CHAR_FORMAT = /[!@#?\]]/.freeze

  validates :first_name, :email, :identification_number, presence: true
  # 1a. Validate email is a valid email address.
  validates :email, format: { with: EMAIL_FORMAT }
  # 1b. Validate email is not already registered in the database.
  validates :email, uniqueness: true
  # 1c. Validate password contains at least 10 characters, one lowercase letter, one
  #     uppercase letter and one of the following characters: !, @, #, ? or ].
  validates :password, length: { minimum: 10 }
  validates :password, format: { with: UPPERCASE_FORMAT, message: 'Must contain at least one uppercase letter'}
  validates :password, format: { with: LOWERCASE_FORMAT, message: 'Must contain at least one lowercase letter'}
  validates :password, format: { with: SPECIAL_CHAR_FORMAT, message: 'Must contain at least one of the following characters: !, @, #, ? or ]'}
end
