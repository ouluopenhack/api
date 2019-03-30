class User < ApplicationRecord
  belongs_to :team
  has_secure_token :token
  enum status: { inactive: 0, pending: 5, active: 10}
  validates :name, presence: true, length: { minimum: 3 }
  validate :unique_active_email

  def confirm
    update(status: "active")
    team.notify_confirm
  end

  def confirmed?
    status == "active"
  end

  private

    def unique_active_email
      emails = User.where(email: email, status: "active")
      errors.add(:base, 'Email already exists') if emails.size > 0
    end
end
