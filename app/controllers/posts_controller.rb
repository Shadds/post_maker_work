class PostsController < ApplicationController
  def index
    input = Posts::Input.new(search_params)
    feed_items = Posts::FeedFilter.new(input).perform

    render :index, locals: { feed_items: feed_items }
  end

  def new
    form = Posts::CreateService::Input.new

    render :new, locals: { form: form }
  end

  def create
    form = Posts::CreateService::Input.new(post_params)
    service = Posts::CreateService.perform(form)
    if service.success?
      redirect_to :posts
    else
      flash.now[:notice] = "Post is invalid: #{service.errors.full_messages}"
      render :new, locals: { form: form }
    end
  end

  def destroy

    SocialContent.find(params[:id]).destroy
    redirect_to request.referrer

    # TODO: add ability to destroy any post
    # 1. Destroy SocialContent /done
    # 2. Destroy related SocialPosts /done
  end

  private

  def post_params
    params.require(:post).permit(:title, :post, :schedule_time, social_networks: [])
  end

  def search_params
    params.permit(:search_text, :date_from, :date_to, social_networks: [])
  end
end
