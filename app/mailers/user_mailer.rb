class UserMailer < ApplicationMailer
  def confirmation(user, team_name, team_token)
    @team_name = team_name
    @team_token = team_token
    @user = user
    mail(to: user.email, subject: "OuluOpenHack 2019 - Confirm your registration")
  end
end
