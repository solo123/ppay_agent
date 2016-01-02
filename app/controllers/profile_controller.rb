class ProfileController < ApplicationController
  def info
    flash[:info] = '你好哇'
  end
end
