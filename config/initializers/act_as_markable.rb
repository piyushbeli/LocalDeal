module Markable
  class Mark < ActiveRecord::Base

    after_save :increment_mark_counter
    after_destroy :decrement_mark_counter

    private
    def increment_mark_counter
      if markable_type == 'Oulet' && mart.to_s == 'favorite'
        markable_type.constantize.increment_counter(:no_of_followers, markable_id)
        marker_type.constantize.increment_counter(:no_of_favorite_outlets, marker_id)
      elsif markable_type == 'Comment' && mark.to_s == 'liked'
        markable_type.constantize.increment_counter(:no_of_likes, markable_id)
      elsif markable_type == 'Comment' && mark.to_s == 'spam'
        markable_type.constantize.increment_counter(:no_of_spams, markable_id)
      elsif markable_type == 'User' && mark.to_s == 'following'
        markable_type.constantize.increment_counter(:no_of_followers, markable_id)
        marker_type.constantize.increment_counter(:no_of_followings, marker_id)
      end
    end


    def decrement_mark_counter
      if markable_type == 'Oulet' && mart.to_s == 'favorite'
        markable_type.constantize.decrement_counter(:no_of_followers, markable_id)
        marker_type.constantize.decrement_counter(:no_of_favorite_outlets, marker_id)
      elsif markable_type == 'Comment' && mark.to_s == 'liked'
        markable_type.constantize.decrement_counter(:no_of_likes, markable_id)
      elsif markable_type == 'Comment' && mark.to_s == 'spam'
        markable_type.constantize.decrement_counter(:no_of_spams, markable_id)
      elsif markable_type == 'User' && mark.to_s == 'following'
        markable_type.constantize.decrement_counter(:no_of_followers, markable_id)
        marker_type.constantize.decrement_counter(:no_of_followings, marker_id)
      end
    end
  end
end


module Markable
  module ActsAsMarkable
    module MarkableInstanceMethods
      alias_method :old_unmark, :unmark

      def decrement_mark_counter(mark, by)
        if mark.to_s == "favorite"
          self.class.decrement_counter(:no_of_followers, self.id)
          by.class.decrement_counter(:no_of_favorite_outlets, by.id)
        elsif mark.to_s == 'like'
          self.class.decrement_counter(:no_of_likes, self.id)
        elsif mark.to_s == 'spam'
          self.class.decrement_counter(:no_of_spams, self.id)
        elsif mark.to_s == 'following'
          by.class.decrement_counter(:no_of_followings, by.id)
          self.class.decrement_counter(:no_of_followers, self.id)
        end
      end

      def unmark(mark, options = {})
        self.old_unmark(mark, options)
        decrement_mark_counter(mark, options[:by])
      end
    end
  end
end