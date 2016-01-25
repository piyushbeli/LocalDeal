module Markable
  class Mark < ActiveRecord::Base

    after_save :increment_favorites_counter
    after_destroy :decrement_favorites_counter

    private
    def increment_favorites_counter
      markable_type.constantize.increment_counter(:no_of_followers, markable_id)
    end

    def decrement_favorites_counter
      markable_type.constantize.decrement_counter(:no_of_followers, markable_id)
    end
  end
end

module Markable
  module ActsAsMarkable
    module MarkableInstanceMethods
      alias_method :old_unmark, :unmark

      def decrement_favorites_counter(mark)
        if mark.to_s == "favorite"
          self.class.decrement_counter(:no_of_followers, self.id)
        end
      end

      def unmark(mark, options = {})
        self.old_unmark(mark, options)
        decrement_favorites_counter(mark)
      end
    end
  end
end