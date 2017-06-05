require 'active_support/concern'

module Calc
  extend ActiveSupport::Concern

  included do

    def sub_total
      line_items.to_a.sum { |i| i.total_price }
    end

    def discount_total
      discount_items.to_a.sum { |i| i.real_value }
    end

    def total
      sub_total - discount_total
    end

    def estimate_duration
      sub_total / ENV['HOUR_RATE'].to_i * 60 * 60
    end

  end

end
