class TweetsController < ApplicationController

before_action :move_to_index, except: :index

  def index
    @tweets =  Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new 
  end

  def create
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
  end

  def destroy
      tweet = Tweet.find(id_params[:id])
      if tweet.user_id == current_user.id
        tweet.destroy
      end
  end

  def edit
      @tweet = Tweet.find(id_params[:id])
  end

  def update
    tweet = Tweet.find(id_params[:id])
    if tweet.user_id == currnt_user.id
      tweet.update(tweet_params)
  end
end

private

  def tweet_params
  params.permit(:image, :text)
  end

  def id_params
      params.permit(:id)
  end

  def move_to_index
  redirect_to action: "index" unless user_signed_in?
  end
end


