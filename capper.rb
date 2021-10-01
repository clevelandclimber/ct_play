class Capper

  attr_reader :gross
  attr_reader :target
  attr_reader :ytd
  attr_reader :new_ytd
  attr_reader :applied

  def initialize(gross, target, ytd)
    @gross = gross
    @target = target
    @ytd = ytd
    if (ytd + gross) >= target
      @new_ytd = target
      @applied =  target - ytd
      @capped = true
    else
      @applied = gross
    end
  end

  def capped?
    @capped
  end

end

