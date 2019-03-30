class HomeController < ApplicationController

  def index
    redirect_to "https://www.ouluopenhack.org"
  end

  def test
    render plain: "test ok"
  end

end