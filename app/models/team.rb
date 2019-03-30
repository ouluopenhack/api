class Team < ApplicationRecord
  enum status: { inactive: 0, pending: 5, active: 10}
  validates :name, presence: true, length: { minimum: 3 }
  has_many :users
  has_secure_token :token

  def notify_confirm
    if confirmed?
      users.each do |user|
        ConfirmationsMailer.welcome(user.email, self).deliver_now
      end
    end
  end

  def confirmed?
    users.all? {|user| user.confirmed? }
  end

  def self.deserialize(json)
    doc = JSON.parse(json)
    team = Team.new(name: doc.fetch("name"))
    if team.valid?
      users = doc.fetch("users")
      raise KeyError unless users.is_a? Array
      users.each do |user|
        raise KeyError unless user.is_a? Hash
        team.users << User.new(name: user.fetch("name"), email: user.fetch("email"))
      end
    end
    team
  end

end
