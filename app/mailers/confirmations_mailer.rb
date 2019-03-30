class ConfirmationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.team_mailer.welcome.subject
  #
  def welcome(email, team)

    @starts_at = EventInformation.starts_at
    @ends_at = EventInformation.ends_at
    @venue = EventInformation.venue
    @team_name = team.name
    @team_token = team.token
    mail to: email, subject: "Welcome to OuluOpenHack, #{@team_name}"
  end
end
