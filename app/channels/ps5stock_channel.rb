class Ps5stockChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ps5stock"
  end

  def unsubscribed
    stop_all_streams
  end
end
