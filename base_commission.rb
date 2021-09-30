class BaseCommission

  ONE_HUND_K = 100_000.00

  def self.call(price, description)
    description = description.gsub /[%$ ]/, ''
    percents, extra = description.split '+'
    percents = percents.split('/')
    last_percent = percents.pop
    commission = percents.reduce(0.0) do |sum, percent|
      price_step = [price, ONE_HUND_K].min
      # puts price_step: price_step, percent: percent, abc: price_step * percent.to_f * 0.01
      sum_step = price_step * percent.to_f * 0.01
      price -= price_step
      sum + sum_step
    end
    # puts price: price, last_percent: last_percent, abc: price * last_percent.to_f * 0.01, commission: commission
    (commission + price * last_percent.to_f * 0.01 + extra.to_f).round(2)
  end

end
