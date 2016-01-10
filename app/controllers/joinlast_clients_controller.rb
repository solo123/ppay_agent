class JoinlastClientsController < ApplicationController
  def index
    @collection = Client.order("join_date DESC").take(10)
  end
end
