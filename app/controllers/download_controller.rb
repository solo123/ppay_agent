class DownloadController < ApplicationController
  def import_xls
    send_file "tmp/#{params[:name]}.#{params[:format]}", type: 'application/vnd.ms-excel', disposition: 'attachment'
  end
end
