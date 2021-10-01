require 'pry'
require 'set'
require_relative 'node'
require_relative 'capper'

class Commission

  def initialize
    @nodes = {}
    build
  end

  def add(id, dependencies = [], &block)
    dependencies = Array(dependencies)
    node = Node.new(self, id, dependencies, block)
    @nodes[id] = node
  end

  def lookup_dependencies(dependencies)
    dependencies.collect do |d|
      @nodes[d] || d
    end
  end

  def [](id)
    @nodes[id]
  end

  def ids
    @nodes.keys
  end

  ONE_HUND_K = 100_000.00

  def self.gross_commission(price, description)
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

  def build
    price = add(:price)
    commission_rate = add(:commission_rate)
    gross_commission = add(:gross_commission, [:price, :commission_rate]) do |c|
      Commission.gross_commission(c[:price].value, c[:commission_rate].value)
    end
    referral_includes_additional_commission = add(:referral_includes_additional_commission)
    additional_commission = add(:additional_commission)
    referral_percent = add(:referral_percent)
    referral_object = add(:referral_object, [:gross_commission, :referral_percent, :additional_commission, :referral_includes_additional_commission]) do |c|
      ReferralFee.new(c[:gross_commission].value, c[:referral_percent].value, include_additional_commission: c[:referral_includes_additional_commission].value, additional_commission: c[:additional_commission].value)
    end
    referral = add(:referral, [:referral_object]) { |c| c[:referral_object].value.referral_amount }
    remaining_commission = add(:remaining_commission, [:referral_object]) { |c| c[:referral_object].value.remaining_commission }
    remaining_additional_commission = add(:remaining_additional_commission, [:referral_object]) { |c| c[:referral_object].value.remaining_additional_commission }
    agent_cut_percent = add(:agent_cut_percent)
    agent_gross_commission = add(:agent_gross_commission, [:agent_cut_percent, :remaining_commission]) { |c| c[:agent_cut_percent].value * c[:remaining_commission].value }

    agent_royalty_target = add(:agent_royalty_target)
    agent_royalty_percent = add(:agent_royalty_percent)
    agent_royalty_ytd = add(:agent_royalty_ytd)
    agent_royalty_object = add(:agent_royalty_object, [:agent_gross_commission, :agent_royalty_target, :agent_royalty_percent, :agent_royalty_ytd]) do |c|
      Capper.new(c[:agent_gross_commission].value * c[:agent_royalty_percent].value, c[:agent_royalty_target].value, c[:agent_royalty_ytd].value)
    end
    agent_royalty_applied = add(:agent_royalty_applied, [:agent_royalty_object]) { |c| c[:agent_royalty_object].value.applied }
    agent_royalty_capped = add(:agent_royalty_capped, [:agent_royalty_object]) { |c| !!c[:agent_royalty_object].value.capped? }
    # agent_royalty_new_ytd = add(:agent_royalty_new_ytd, [:agent_royalty_object]) { |c| c[:agent_royalty_object].value.new_ytd } # REDO AS MATH

    agent_cap_target = add(:agent_cap_target)
    agent_cap_percent = add(:agent_cap_percent)
    agent_cap_ytd = add(:agent_cap_ytd)
    agent_cap_object = add(:agent_cap_object, [:agent_gross_commission, :agent_cap_target, :agent_cap_percent, :agent_cap_ytd]) do |c|
      Capper.new(c[:agent_gross_commission].value * c[:agent_cap_percent].value, c[:agent_cap_target].value, c[:agent_cap_ytd].value)
    end
    agent_cap_applied = add(:agent_cap_applied, [:agent_cap_object]) { |c| c[:agent_cap_object].value.applied }
    agent_cap_capped = add(:agent_cap_capped, [:agent_cap_object]) { |c| !!c[:agent_cap_object].value.capped? }
    # agent_cap_new_ytd = add(:agent_cap_new_ytd, [:agent_cap_object]) { |c| c[:agent_cap_object].value.new_ytd } # REDO AS MATH

    agent_net = add(:agent_net, [:agent_gross_commission, :agent_royalty_applied, :agent_cap_applied]) { |c| c[:agent_gross_commission].value - c[:agent_royalty_applied].value - c[:agent_cap_applied].value }

    ja_gross_commission = add(:ja_gross_commission, [:agent_cut_percent, :remaining_commission, :remaining_additional_commission]) do |c|
      (1.0 - c[:agent_cut_percent].value) * c[:remaining_commission].value + c[:remaining_additional_commission].value
    end

    ja_royalty_target = add(:ja_royalty_target)
    ja_royalty_percent = add(:ja_royalty_percent)
    ja_royalty_ytd = add(:ja_royalty_ytd)
    ja_royalty_object = add(:ja_royalty_object, [:ja_gross_commission, :ja_royalty_target, :ja_royalty_percent, :ja_royalty_ytd]) do |c|
      Capper.new(c[:ja_gross_commission].value * c[:ja_royalty_percent].value, c[:ja_royalty_target].value, c[:ja_royalty_ytd].value)
    end
    ja_royalty_applied = add(:ja_royalty_applied, [:ja_royalty_object]) { |c| c[:ja_royalty_object].value.applied }
    ja_royalty_capped = add(:ja_royalty_capped, [:ja_royalty_object]) { |c| !!c[:ja_royalty_object].value.capped? }
    # ja_royalty_new_ytd = add(:ja_royalty_new_ytd, [:ja_royalty_object]) { |c| c[:ja_royalty_object].value.new_ytd } # REDO AS MATH

    ja_cap_target = add(:ja_cap_target)
    ja_cap_percent = add(:ja_cap_percent)
    ja_cap_ytd = add(:ja_cap_ytd)
    ja_cap_object = add(:ja_cap_object, [:ja_gross_commission, :ja_cap_target, :ja_cap_percent, :ja_cap_ytd]) do |c|
      Capper.new(c[:ja_gross_commission].value * c[:ja_cap_percent].value, c[:ja_cap_target].value, c[:ja_cap_ytd].value)
    end
    ja_cap_applied = add(:ja_cap_applied, [:ja_cap_object]) { |c| c[:ja_cap_object].value.applied }
    ja_cap_capped = add(:ja_cap_capped, [:ja_cap_object]) { |c| !!c[:ja_cap_object].value.capped? }
    # ja_cap_new_ytd = add(:ja_cap_new_ytd, [:ja_cap_object]) { |c| c[:ja_cap_object].value.new_ytd } # REDO AS MATH

    ja_net = add(:ja_net, [:ja_gross_commission, :ja_royalty_applied, :ja_cap_applied]) { |c| c[:ja_gross_commission].value - c[:ja_royalty_applied].value - c[:ja_cap_applied].value }

    # ja_cap.each_dependency.each do |node|
    #   puts node.id unless node.has_dependencies?
    # end
  end
    # puts

    # # puts ids.sort.collect { |id| "#{id} #{id.class}" }

    # :price].value = 245_000.00
    # :commission_rate].value = "3 / 2 %"
    # :agent_cut_percent].value = 0.65
    # :referral_percent].value = 0.0
    # :additional_commission].value = 480.0
    # :referral_includes_additional_commission].value = false
    # :agent_royalty_target].value = 3_000.00
    # :agent_royalty_percent].value = 0.30
    # :agent_royalty_ytd].value = 0.00
    # :agent_cap_target].value = 5_000.00
    # :agent_cap_percent].value = 0.30
    # :agent_cap_ytd].value = 0.00
    # :ja_royalty_target].value = 3_000.00
    # :ja_royalty_percent].value = 0.6
    # :ja_royalty_ytd].value = 0.00
    # :ja_cap_target].value = 13_000.00
    # :ja_cap_percent].value = 0.15
    # :ja_cap_ytd].value = 0.00

    # puts :price]
    # puts :commission_rate]
    # puts :gross_commission]


    # puts :ja_cap_target]
    # puts :ja_cap_percent]
    # puts :ja_cap_ytd]




  # end

end
