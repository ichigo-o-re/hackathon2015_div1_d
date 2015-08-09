class TweetController < ApplicationController

  def before_index

  end
  # GET /
  def index
    @tweets = Tweet.last(20).reverse
  end

  # GET /tweets/more/:id.json
  def more
    @tweets = Tweet.where("id > ?", params[:id]).limit(5)
  end

  # POST /tweets
  def create
    @tweet = Tweet.new
    @tweet.text = params[:text]
    p params
    p request.body.read
    respond_to do |format|
      if @tweet.save
        pp @tweet.to_json
        format.json { render json: @tweet }
      else
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def tweet_params
    params.require(:tweet).permit(:id, :reply_to_id, :text, :created_at)
  end
end
