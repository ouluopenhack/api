require 'test_helper'

class TeamDeserializationTest < ActiveSupport::TestCase

  def valid_json
    {
      name: "Team Name 1",
      users: [
        { name: "Bill", email: "bill@localhost.localdomain" },
        { name: "Sarah", email: "sarah@localhost.localdomain" }
      ]
    }.to_json
  end

  test "it creates new Team model with correct name" do
    team = Team.deserialize(valid_json)
    assert team.valid?
    assert_equal "Team Name 1", team.name
  end

  test "it creates a Team model with users" do
    team = Team.deserialize(valid_json)
    assert_equal 2, team.users.size
  end

  test "it throws error with invalid JSON" do
    assert_raise JSON::ParserError do
      Team.deserialize("invalid json")
    end
  end

  test "it throws error when JSON does not have correct elements" do
    assert_raise KeyError do
      Team.deserialize( { title: "jee", members: [{first_name: "bob"}]}.to_json)
    end
  end
end