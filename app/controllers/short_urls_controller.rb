class ShortUrlsController < ApplicationController

  # find the real link for the shortened link key and redirect
  def show
    # only use the leading valid characters
    # token = /^([#{ShortUrl.key_chars.join}]*).*/.match(params[:id])[1]

    # pull the link out of the db
    sl = ShortUrl.find_by_uid(params[:id])
    if sl
      # don't want to wait for the increment to happen, make it snappy!
      # this is the place to enhance the metrics captured
      # for the system. You could log the request origin
      # browser type, ip address etc.
      Thread.new do
        sl.increment!(:hits)
        ActiveRecord::Base.connection.close
      end
      # do a 301 redirect to the destination url
      redirect_to sl.url, :status => :moved_permanently
    else
      # if we don't find the shortened link, redirect to the root
      # make this configurable in future versions
      redirect_to '/'
    end
  end

end
