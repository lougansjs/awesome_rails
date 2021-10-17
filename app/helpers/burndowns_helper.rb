# frozen_string_literal: true

# Helpers for burndowns
module BurndownsHelper
  def skip_weekends(array_dates)
    array_dates.reject { |date| date.to_date.saturday? || date.to_date.sunday? }
  end
end
