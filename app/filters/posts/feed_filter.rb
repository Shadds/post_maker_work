module Posts
  class FeedFilter < BaseFilter

    def perform

      # item = SocialContent.where(title: "TITLE3").or(SocialContent.where(post: "POST4"))
      # p 'AAAAAAAA'
      # p item


      # Customer.where(last_name: 'Smith').or(Customer.where(orders_count: [1,3,5]))


      # if input.social_network.nil? && input.data_to.nil? && input.date_from.nil?
      #   base_scope
      #   # p 'PPPPPPPPP'
      # end
      # p input
      # p 'AAAAAAAA'

      # if input.search_text.empty?
        # p 'MMMMMMMMM'
        # return SocialContent.find_by title: 'twitter'
      # end


      # irb> Customer.find_by first_name: 'Lifo'
      # => #<Customer id: 1, first_name: "Lifo">
      #
      # irb> Customer.find_by first_name: 'Jon'
      # => nil
      # SocialContent.all.includes(:social_posts)
      # SocialContent.order(params[:title], params[:post], params[:social_networks], params[:datetime_from])..params[:datetime_to])

      # Поставить проверку если не пришел ни один параметр, показать ошибку

      # TODO:
      # 1. apply all filters that come from input
      #   - filter by title/post contains search_text
      #   - filter by social networks
      #   - filter by date range (date_from, date_to)

      base_scope
    end

    private

    # NOTE: this method can be modified
    def base_scope
      # p input
      # p 'AAAAAAA'
      # Что бы фильтр по search_text работал нужно розкоментировать даную строчку,
      # а строчку SocialContent.all.includes(:social_posts) закоментировать
      SocialContent.where(title: input.search_text).or(SocialContent.where(post: input.search_text)).includes(:social_posts)
      # SocialContent.where(social_network: input.social_networks)
      SocialContent.all.includes(:social_posts)
    end
  end
end
