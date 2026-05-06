class HomesController < ApplicationController
  allow_unauthenticated_access

  def top
    if authenticated?
      redirect_to mypage_path
    end
  end

  def about
  end
end
