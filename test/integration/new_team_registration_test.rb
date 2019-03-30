require 'test_helper'
require 'uri'

class NewTeamRegistrationTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::UrlHelper
#  1. Send HTTP POST with team details [:name, members: [:email, :name] ]
#  2. Send confirmation emails to all members
#  3. Wait until everybody has clicked the confirmation link
#    - Show "confirmed but waiting for others" page
#  4. On last confirmation, show "Your team participation is confirmed" page
#  5. Send event invitations to all team members
#    - Team TOKEN
  def confirmation_link
    # due to a bug(?) the named path is wrong when this url is created,
    # solved by hardcoding the url

    "http://localhost:5000/v1/confirmations/"
  end
  def default_request
    {
      name: "Team unknown",
      users: [
        { email: "sylvia@localhost.localdomain", name: "Sylvia" },
        { email: "esther@localhost.localdomain", name: "Esther" },
        { email: "hyacinth@localhost.localdomain", name: "Hyacinth Buckét" },
        { email: "onslow@localhost.localdomain", name: "Onslow" }
      ]
    }
  end

  test "register team with HTTP POST request" do
    post teams_path, as: :json, params: default_request
    assert_response :success
  end

  test "send confirmation emails to all team members" do
    enqueued_jobs do
      assert_emails 4 do
        post teams_path, as: :json, params: default_request
      end
    end
  end

  test "team members confirm attendance" do
    post teams_path, as: :json, params: default_request
    ActionMailer::Base.deliveries.clear
    assert_equal 0, ActionMailer::Base.deliveries.size
    enqueued_jobs do
      assert_difference 'ActionMailer::Base.deliveries.size', +4 do
        urls_from_confirmation_emails.each do |url|
          get url
          assert_response :success
        end
      end
    end

  end

  test "all team members get a correct welcome email after clicking the confirmation link on email" do
    post teams_path, as: :json, params: default_request
    urls = urls_from_confirmation_emails
    assert_emails 4 do
      urls.each do |url|
        get url
        assert_response :redirect
      end
    end
    ActionMailer::Base.deliveries.each do |email|
      assert_match /Welcome to Oulu Open Hack 2019!/, email.html_part.body.to_s
    end
  end

  def urls_from_confirmation_emails
    ActionMailer::Base.deliveries.map{ |email| URI.extract(email.html_part.body.to_s).select {|x| x.start_with?(confirmation_link)} }.flatten
  end
end
