class ConfirmationsController < ApplicationController

  def confirm
    browser = Browser.new(request.env["HTTP_USER_AGENT"])
    if browser.bot?
      render plain: "Hello bot"
    else
      if(user = User.find_by(token: params[:token], status: "pending"))
        user.confirm

        redirect_to "https://www.ouluopenhack.org/confirmed.html"
      else
        render plain: "<marquee>o hai!</marquee>"
      end

    end
  end
end
