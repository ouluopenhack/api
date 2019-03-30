class TeamsController < ApplicationController
  def create
    team = Team.deserialize(request.body.read)
    if team.save
      send_confirmation_emails(team)
      json_response(team.to_json)
    else
      json_response({message: team.errors.full_messages + team.users.map {|u| u.errors.full_messages}.flatten }, :unprocessable_entity)
    end
  rescue JSON::ParserError
    json_response({message: "JSON parser error, request not valid JSON"}, :unprocessable_entity)
  rescue KeyError => e
    json_response({message: "Document structure invalid, error message: #{e.message}"}, :unprocessable_entity)
  end

  private

    def json_response(response_body, status = :ok)
      render json: response_body, status: status
    end

    def send_confirmation_emails(team)
      team.users.each do |user|
        UserMailer.confirmation(user, team.name, team.token).deliver_now!
        user.update(status: "pending")
      end
    end
end
