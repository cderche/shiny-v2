class Discount < ApplicationRecord
  enum discount_type: [:fixed, :percentage]

  validates :coupon         , presence: true
  validates :value          , presence: true
  validates :discount_type  , presence: true
  # http://guides.rubyonrails.org/active_record_validations.html#presence
  validates :recurring, inclusion: { in: [true, false] }
  validates :recurring, exclusion: { in: [nil] }

end
