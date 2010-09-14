module ActiveRecord
  module Acts #:nodoc:
    module Purchasable #:nodoc:
      def acts_as_purchasable(options = {})
        configuration = { :name => "name", :price => "price" }
        configuration.update(options) if options.is_a?(Hash)

        class_eval <<-EOV
          has_many :purchases, :as => :purchasable

          def purchase( quantity = 1 )
            Purchase.new :name             => self.#{configuration[:name]},
                         :price            => self.#{configuration[:price]},
                         :quantity         => quantity,
                         :purchasable_id   => self.id,
                         :purchasable_type => self.class
          end
        EOV
      end
    end
  end
end
