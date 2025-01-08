class HomeController < ApplicationController
  def greetings
    render json: { greetings: I18n.t(:hello) }
  end
end
