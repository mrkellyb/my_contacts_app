class Contact < ApplicationRecord

  belongs_to :user
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  def friendly_updated_at
    updated_at.strftime("%A, %b %d, %Y %l:%M%p")
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
