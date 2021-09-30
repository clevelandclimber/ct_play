class ReferralFee

  attr_reader :referral_fee
  attr_reader :remaining_commission
  attr_reader :remaining_additional_commission

  def initialize(commission, percent, include_additional_commission: , additional_commission: 480.00)
    if percent.is_a? Symbol
      @referral_fee = percent
      @remaining_commission = commission
      @remaining_additional_commission = additional_commission
    else
      referral_from_commission = commission * percent
      referral_from_additional_commission = include_additional_commission ? additional_commission * percent : 0.0
      @referral_fee = referral_from_commission + referral_from_additional_commission
      @remaining_commission = commission - referral_from_commission
      @remaining_additional_commission = additional_commission - referral_from_additional_commission
    end
  end

end
