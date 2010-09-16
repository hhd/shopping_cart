$:.unshift "#{File.dirname(__FILE__)}/lib"
require 'active_record/acts/purchasable'
ActiveRecord::Base.class_eval { extend ActiveRecord::Acts::Purchasable }
ActionView::Base.send :include, PurchasableHelper

