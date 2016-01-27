module Markable
  class Mark < ActiveRecord::Base

    after_save :increment_mark_counter
    after_destroy :decrement_mark_counter

    private
    def increment_mark_counter
      if markable_type == 'Oulet' && mart.to_s == 'favorite'
        markable_type.constantize.increment_counter(:no_of_followers, markable_id)
      elsif markable_type == 'Comment' && mark.to_s == 'liked'
        markable_type.constantize.increment_counter(:no_of_likes, markable_id)
      elsif markable_type == 'Comment' && mark.to_s == 'span'
        markable_type.constantize.increment_counter(:no_of_spams, markable_id)
      end
    end


    def decrement_mark_counter
      if markable_type == 'Oulet' && mart.to_s == 'favorite'
        markable_type.constantize.decrement_counter(:no_of_followers, markable_id)
      elsif markable_type == 'Comment' && mark.to_s == 'liked'
        markable_type.constantize.decrement_counter(:no_of_likes, markable_id)
      elsif markable_type == 'Comment' && mark.to_s == 'span'
        markable_type.constantize.decrement_counter(:no_of_spams, markable_id)
      end
    end
  end
end


module Markable
  module ActsAsMarkable
    module MarkableInstanceMethods
      alias_method :old_unmark, :unmark

      def decrement_mark_counter(mark)
        if mark.to_s == "favorite"
          self.class.decrement_counter(:no_of_followers, self.id)
        elsif mark_to_s == 'like'
          self.class.decrement_counter(:no_of_likes, self.id)
        elsif mark_to_s == 'spam'
          self.class.decrement_counter(:no_of_spams, self.id)
        end
      end

      def unmark(mark, options = {})
        self.old_unmark(mark, options)
        decrement_mark_counter(mark)
      end
    end
  end
end