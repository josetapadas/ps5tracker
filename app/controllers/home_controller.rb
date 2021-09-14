class HomeController < ApplicationController
  def home
    PlaystationWorker.perform_async
  end
end
