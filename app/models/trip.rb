# frozen_string_literal: true

class Trip < ApplicationRecord
  # could be written better :)
  ## Constants
  VALID_ADDRESS_REGEXP =/\A[\w'()&.\s-]+,\s[\w'()&.\s-]+,\s[\w'()&.\s-]+\z/
  ## Validations
  validates :start_address, presence: true, format: { with: VALID_ADDRESS_REGEXP }
  validates :destination_address, presence: true, format: { with: VALID_ADDRESS_REGEXP }
  validates :price, presence: true
end
