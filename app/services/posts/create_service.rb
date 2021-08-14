module Posts
  class CreateService < Service
    class Input < BaseInput
      attribute :title, type: String
      attribute :post, type: String
      attribute :social_networks, array: true
      attribute :schedule_time, type: Date

      validates :title, presence: true
      validates :post, presence: true
      validates :schedule_time, presence: true
    end

    attr_reader :input, :post

    def perform

      if input.title.length < 1 || input.title.length > 50
        return errors.add(:base, 'Title должен содержать от 1 до 50 символов')
      end

      if input.post.length < 1 || input.post.length > 250
        return errors.add(:base, 'Post должен содержать от 1 до 250 символов')
      end

      if input.schedule_time.nil? || input.schedule_time <= DateTime.current.to_date
        return errors.add(:base, 'Вы ввели неправильную дату')
      end

      #TODO
      #Please read about ActiveRecord::Base.transaction, понять як відправити транзакцію

      SocialContent.create(title: input.title , post: input.post)

      for item in input.social_networks do
          if item != ""
            SocialContent.last.social_posts.create(schedule_time: input.schedule_time, social_network: item)
          end
      end

      # TODO:
      # 1. create SocialContent with title and post from input /done
      # 2. create as many related SocialPosts as many social_networks you have selected /done
      # 3. care about data consistency (Please read about ActiveRecord::Base.transaction) /not yet
      # 4. You must not create any SocialContent and SocialPosts: /done
      #   - if schedule_time in the past
      #   - if social_networks is empty array
      #   - if post length more then 250 symbols
      #   - if title length more then 50 symbols

      #errors.add(:base, 'Perform functionality not implemented yet!')

      #@post = nil # Please replace 'nil' with real created post
    end
  end
end
