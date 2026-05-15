class FollowsController < ApplicationController
  def create
    @follow = Current.user.follower.built(:)
  end

end
