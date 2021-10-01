# require_relative 'base_commission'
require_relative 'referral_fee'
require_relative 'table'
require_relative 'commission'

AGENT_RATES = {
# Agent Royalty  Cap    JA Cut
   ER: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.65, capped: false },
   SK: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.65, capped: false },
   BD: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.60, capped: false },
   BW: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.60, capped: false },
   CB: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.60, capped: true  },
   CI: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.65, capped: false },
   AB: { royalty: 0.00,  cap: 0.15, ja_cut: 1.0-0.70, capped: false },
   JA: { royalty: 0.06,  cap: 0.15, ja_cut: 1.0     , capped: false },
}

SOURCES = {
  "Sphere" =>                      { percent: 0.00,        include_additional_commission: false },
  "AAG" =>                         { percent: 0.25,        include_additional_commission: false },
  "Agent Pronto" =>                { percent: 0.25,        include_additional_commission: false },
  "Agent Referral Exchange 25%" => { percent: 0.25,        include_additional_commission: false },
  "Agent Referral Exchange 30%" => { percent: 0.30,        include_additional_commission: false },
  "American Star 25%" =>           { percent: 0.25,        include_additional_commission: false },
  "CT - Website" =>                { percent: 0.00,        include_additional_commission: false },
  "Fairway - Dominic" =>           { percent: 0.00,        include_additional_commission: false },
  "Homes.com" =>                   { percent: 0.00,        include_additional_commission: false },
  "Homesnap" =>                    { percent: 0.00,        include_additional_commission: false },
  "Internet" =>                    { percent: 0.00,        include_additional_commission: false },
  "Market Leader" =>               { percent: 0.00,        include_additional_commission: false },
  "OpCity 30%" =>                  { percent: 0.30,        include_additional_commission: true  },
  "OpCity 35%" =>                  { percent: 0.35,        include_additional_commission: true  },
  "OpCity 38%" =>                  { percent: 0.38,        include_additional_commission: true  },
  "Quantum Digital" =>             { percent: 0.00,        include_additional_commission: false },
  "Realtor.com" =>                 { percent: 0.00,        include_additional_commission: false },
  "Reazo" =>                       { percent: 0.00,        include_additional_commission: false },
  "Referral - Affiliate" =>        { percent: 0.00,        include_additional_commission: false },
  "Referral - Agent" =>            { percent: 0.00, include_additional_commission: false },# :variable
  "Sign Call" =>                   { percent: 0.00,        include_additional_commission: false },
  "Social - FB Ad" =>              { percent: 0.00,        include_additional_commission: false },
  "Sold.com 25%" =>                { percent: 0.25,        include_additional_commission: false },
  "Zillow" =>                      { percent: 0.00,        include_additional_commission: false },
  "Zillow - Carolee" =>            { percent: 0.00,        include_additional_commission: false },
}


TRANSACTIONS = [
{ address: "Foothill Blvd 3673, Willoughby",  price: 245_000.00, commission_rate: "3 / 2 %", commission:  5_900.00, agent: :CI, source: "Market Leader",    referral:     0.00, agent_royalty: 230.10, agent_cap:   0.00, agent_net_commission: 3_604.90 },
{ address: "Slate Ct 1388, Cleveland Hts",    price: 410_000.00, commission_rate: "4 / 3 %", commission: 13_300.00, agent: :JA, source: "Sold.com 25%",     referral: 3_325.00, agent_royalty:   0.00, agent_cap:   0.00, agent_net_commission:     0.00 },
{ address: "Monticello Dr 62, Brunswick",     price: 275_000.62, commission_rate: "3 / 2 %", commission:  6_500.02, agent: :AB, source: "Sphere",           referral:     0.00, agent_royalty:   0.00, agent_cap: 682.50, agent_net_commission: 3_867.52 },
{ address: "Dawncliff Dr 4177, Brooklyn",     price: 191_000.00, commission_rate: "4 / 3 %", commission:  6_730.00, agent: :AB, source: "Sphere",           referral:     0.00, agent_royalty:   0.00, agent_cap: 706.65, agent_net_commission: 4_004.35 },
{ address: "Mildred Dr 30225, Willowick",     price: 181_500.00, commission_rate: "3 / 2 %", commission:  4_630.00, agent: :AB, source: "OpCity 35%",       referral: 1_788.50, agent_royalty:   0.00, agent_cap: 298.36, agent_net_commission: 1_690.69 },
{ address: "Belleshire Ave 13801, Cleveland", price:  99_000.00, commission_rate: "2.5 %",   commission:  2_475.00, agent: :CB, source: "Zillow - Carolee", referral:     0.00, agent_royalty:  89.10, agent_cap:   0.00, agent_net_commission: 1_395.90 },
{ address: "N Jester Pl 7147, Concord",       price: 200_000.00, commission_rate: "3 / 2 %", commission:  5_000.00, agent: :JA, source: "Referral - Agent", referral: 1_250.00, agent_royalty:   0.00, agent_cap:   0.00, agent_net_commission:     0.00 },
{ address: "Rainier Ct #153 5568, Parma",     price: 128_000.00, commission_rate: "3 / 2 %", commission:  3_560.00, agent: :JA, source: "Sphere",           referral:     0.00, agent_royalty:   0.00, agent_cap:   0.00, agent_net_commission:     0.00 },
{ address: "Spokane Ave 4001, Cleveland",     price:  79_000.00, commission_rate: "3 / 2 %", commission:  2_370.00, agent: :AB, source: "Sign Call",        referral:     0.00, agent_royalty:   0.00, agent_cap: 248.85, agent_net_commission: 1_410.15 },
{ address: "Menlo Rd 3597, Shaker Hts",       price:  50_000.00, commission_rate: "4%",      commission:  2_000.00, agent: :JA, source: "Agent Pronto",     referral:   500.00, agent_royalty:   0.00, agent_cap:   0.00, agent_net_commission:     0.00 },
{ address: "Eagle St 534, Fairport Harbor",   price: 149_900.00, commission_rate: "3 / 2 %", commission:  3_998.00, agent: :AB, source: "Sphere",           referral:     0.00, agent_royalty:   0.00, agent_cap: 419.79, agent_net_commission: 2_378.81 },
{ address: "W Prospect Rd 1937, Ashtabula",   price: 120_000.00, commission_rate: "3  %",    commission:  3_600.00, agent: :JA, source: "Referral - Agent", referral:   900.00, agent_royalty:   0.00, agent_cap:   0.00, agent_net_commission:     0.00 },
{ address: "Whitehaven Dr 8204, Parma",       price: 160_000.00, commission_rate: "3 / 2 %", commission:  4_200.00, agent: :CB, source: "Zillow - Carolee", referral:     0.00, agent_royalty: 151.20, agent_cap:   0.00, agent_net_commission: 2_368.80 },
{ address: "Sandhurst Dr 6393, Brook Park",   price: 169_900.00, commission_rate: "3 / 2 %", commission:  4_398.00, agent: :CB, source: "Zillow - Carolee", referral:     0.00, agent_royalty: 158.33, agent_cap:   0.00, agent_net_commission: 2_480.47 },
{ address: "Tyler Ave 13618, Cleveland",      price: 120_000.00, commission_rate: "3 / 2 %", commission:  3_400.00, agent: :CB, source: "Zillow - Carolee", referral:     0.00, agent_royalty:  61.20, agent_cap:   0.00, agent_net_commission: 1_978.80 },
{ address: "Oak St 12908, Garfield Hts",      price: 102_000.00, commission_rate: "3 / 2 %", commission:  3_040.00, agent: :CB, source: "Zillow - Carolee", referral:     0.00, agent_royalty: 109.44, agent_cap:   0.00, agent_net_commission: 1_714.56 },
]

T2 = [
{ address: "Foothill Blvd 3673, Willoughby",  price: 245_000.00, commission_rate: "3 / 2 %", agent_cut_percent: 0.65, referral_percent: 0.0, additional_commission: 480.0, referral_includes_additional_commission: false, agent_royalty_target: 3_000.00, agent_royalty_percent: 0.06, agent_royalty_ytd: 0.00, agent_cap_target: 5_000.00, agent_cap_percent: 0.30, agent_cap_ytd: 5_000.00, ja_royalty_target: 3_000.00, ja_royalty_percent: 0.06, ja_royalty_ytd: 0.00, ja_cap_target: 13_000.00, ja_cap_percent: 0.15, ja_cap_ytd: 0.00, },
{ address: "Foothill Blvd 3673, Willoughby",  price: 245_000.00, commission_rate: "3 / 2 %", agent: :CI, source: "Market Leader",    },
{ address: "Slate Ct 1388, Cleveland Hts",    price: 410_000.00, commission_rate: "4 / 3 %", agent: :JA, source: "Sold.com 25%",     },
{ address: "Monticello Dr 62, Brunswick",     price: 275_000.62, commission_rate: "3 / 2 %", agent: :AB, source: "Sphere",           },
{ address: "Dawncliff Dr 4177, Brooklyn",     price: 191_000.00, commission_rate: "4 / 3 %", agent: :AB, source: "Sphere",           },
{ address: "Mildred Dr 30225, Willowick",     price: 181_500.00, commission_rate: "3 / 2 %", agent: :AB, source: "OpCity 35%",       },
{ address: "Belleshire Ave 13801, Cleveland", price:  99_000.00, commission_rate: "2.5 %",   agent: :CB, source: "Zillow - Carolee", },
{ address: "N Jester Pl 7147, Concord",       price: 200_000.00, commission_rate: "3 / 2 %", agent: :JA, source: "Referral - Agent", },
{ address: "Rainier Ct #153 5568, Parma",     price: 128_000.00, commission_rate: "3 / 2 %", agent: :JA, source: "Sphere",           },
{ address: "Spokane Ave 4001, Cleveland",     price:  79_000.00, commission_rate: "3 / 2 %", agent: :AB, source: "Sign Call",        },
{ address: "Menlo Rd 3597, Shaker Hts",       price:  50_000.00, commission_rate: "4%",      agent: :JA, source: "Agent Pronto",     },
{ address: "Eagle St 534, Fairport Harbor",   price: 149_900.00, commission_rate: "3 / 2 %", agent: :AB, source: "Sphere",           },
{ address: "W Prospect Rd 1937, Ashtabula",   price: 120_000.00, commission_rate: "3  %",    agent: :JA, source: "Referral - Agent", },
{ address: "Whitehaven Dr 8204, Parma",       price: 160_000.00, commission_rate: "3 / 2 %", agent: :CB, source: "Zillow - Carolee", },
{ address: "Sandhurst Dr 6393, Brook Park",   price: 169_900.00, commission_rate: "3 / 2 %", agent: :CB, source: "Zillow - Carolee", },
{ address: "Tyler Ave 13618, Cleveland",      price: 120_000.00, commission_rate: "3 / 2 %", agent: :CB, source: "Zillow - Carolee", },
{ address: "Oak St 12908, Garfield Hts",      price: 102_000.00, commission_rate: "3 / 2 %", agent: :CB, source: "Zillow - Carolee", },
]


T2.each do |t|
  puts "=" * 80
  puts t[:address]
  puts "-" * 80
  c = Commission.new
  t.each do |key, value|
    next if %i(address).include? key
    c[key].value = value
  end

  puts gross_commission: c[:gross_commission].value
  puts referral: c[:referral].value
  puts agent_gross_commission: c[:agent_gross_commission].value
  puts agent_royalty_applied: c[:agent_royalty_applied].value
  puts agent_cap_applied: c[:agent_cap_applied].value
  puts agent_net: c[:agent_net].value
  puts ja_gross_commission: c[:ja_gross_commission].value
  puts ja_royalty_applied: c[:ja_royalty_applied].value
  puts ja_cap_applied: c[:ja_cap_applied].value
  puts ja_net: c[:ja_net].value

end

# c = Commission.new

# c[:price].value = 245_000.00
# c[:commission_rate].value = "3 / 2 %"
# c[:agent_cut_percent].value = 0.65
# c[:referral_percent].value = 0.0
# c[:additional_commission].value = 480.0
# c[:referral_includes_additional_commission].value = false
# c[:agent_cut_percent].value = 0.65
# c[:agent_royalty_target].value = 3_000.00
# c[:agent_royalty_percent].value = 0.06
# c[:agent_royalty_ytd].value = 0.00
# c[:agent_cap_target].value = 5_000.00
# c[:agent_cap_percent].value = 0.30
# c[:agent_cap_ytd].value = 5_000.00
# c[:ja_royalty_target].value = 3_000.00
# c[:ja_royalty_percent].value = 0.06
# c[:ja_royalty_ytd].value = 0.00
# c[:ja_cap_target].value = 13_000.00
# c[:ja_cap_percent].value = 0.15
# c[:ja_cap_ytd].value = 0.00

# puts "-----"
# puts gross_commission: c[:gross_commission].value
# puts referral: c[:referral].value
# puts agent_gross_commission: c[:agent_gross_commission].value
# puts agent_royalty_applied: c[:agent_royalty_applied].value
# puts agent_cap_applied: c[:agent_cap_applied].value
# puts agent_net: c[:agent_net].value
# puts ja_gross_commission: c[:ja_gross_commission].value
# puts ja_royalty_applied: c[:ja_royalty_applied].value
# puts ja_cap_applied: c[:ja_cap_applied].value
# puts ja_net: c[:ja_net].value
# puts "-----"

# table = Table.new
# # table.formats = [Table::STRING, Table::US_CURRENCY, Table::STRING, Table::US_CURRENCY, Table::STRING, Table::PERCENT0, Table::PERCENT0]
# # table.aligns = [Table::LEFT, Table::RIGHT, Table::RIGHT, Table::RIGHT, Table::LEFT, Table::RIGHT, Table::RIGHT]
# # table.headers = %w(Address Price Rate Calculated Agent Agent_Cut JA_Cut)
# table.headers = [
#   "Address",
#   ["Price", Table::US_CURRENCY],
#   "Rate",
#   ["Sheet\nCommission", Table::US_CURRENCY],
#   ["Calc\nCommission", Table::US_CURRENCY],
#   "Diff",
#   "Agent",
#   ["Agent\nCut", Table::PERCENT0],
#   ["JA\nCut", Table::PERCENT0],
#   "Source",
#   ["Referral\nPercent", Table::PERCENT0],
#   ["Sheet\nReferral", Table::US_CURRENCY],
#   ["Calc\nReferral", Table::US_CURRENCY],
#   "Diff",
#   ["Remaining\nCommission", Table::US_CURRENCY],
#   ["Additional\nCommission", Table::US_CURRENCY],
#   ["Remaining\nAdditional\nCommission", Table::US_CURRENCY],
#   ["Agent\nTotal\nCommission", Table::US_CURRENCY],
#   ["Sheet\nAgent\nRoyalty", Table::US_CURRENCY],
#   ["Calc\nAgent\nRoyalty", Table::US_CURRENCY],
#   "Diff",
#   ["Sheet\nAgent\nCap", Table::US_CURRENCY],
#   ["Calc\nAgent\nCap", Table::US_CURRENCY],
#   "Diff",
#   ["Sheet\nAgent\nNet\nCommission", Table::US_CURRENCY],
#   ["Calc\nAgent\nNet\nCommission", Table::US_CURRENCY],
#   "Diff",
#   ["JA\nTotal\nCommission\n***", Table::US_CURRENCY],
# ]

# DIFF = "<-"

# def diffize(f1, f2)
#   ((f1 - f2).abs >= 0.05) ? DIFF : ""
# end

# TRANSACTIONS.each do |t|
#   a = AGENT_RATES[t[:agent]]
#   calculated_commission = BaseCommission.call t[:price], t[:commission_rate]
#   source = SOURCES[t[:source]]
#   referral = ReferralFee.new(t[:commission], source[:percent], include_additional_commission: source[:include_additional_commission])
#   remaining_commission = (referral.referral_fee == t[:referral]) ? referral.remaining_commission : (calculated_commission - t[:referral])
#   ja_percent = a[:ja_cut]
#   agent_percent = 1.0 - ja_percent
#   agent_total_commmission = remaining_commission * agent_percent
#   agent_royalty = agent_total_commmission * a[:royalty]
#   agent_cap = a[agent_total_commmission * a[:cap]
#   agent_net_commission = agent_total_commmission - agent_royalty - agent_cap
#   ja_total_commission = remaining_commission * ja_percent
#   table.add(
#     t[:address], # Address
#     t[:price], # Price
#     t[:commission_rate], # Rate
#     t[:commission], # Sheet Commission
#     calculated_commission, # Calc Commission
#     diffize(t[:commission], calculated_commission),
#     t[:agent], # Agent
#     agent_percent, # Agent Cut
#     ja_percent, # JA Cut
#     t[:source], # Source
#     source[:percent], # Referral Percent
#     t[:referral], # Sheet Referral
#     referral.referral_fee, # Calc Referral
#     diffize(t[:referral], referral.referral_fee),
#     remaining_commission, # Remaining Commission
#     480.00, # Additional Commission
#     referral.remaining_additional_commission, # Remaining Additional Commission
#     agent_total_commmission, # Agent Total Commission
#     t[:agent_royalty], # Sheet Agent Royalty
#     agent_royalty, # Agent Royalty
#     diffize(t[:agent_royalty], agent_royalty),
#     t[:agent_cap], # Sheet Agent Cap
#     agent_cap, # Agent Cap
#     diffize(t[:agent_cap], agent_cap),
#     t[:agent_net_commission], # Sheet Agent Net Commission
#     agent_net_commission, # Agent Net Commission
#     diffize(t[:agent_net_commission], agent_net_commission),
#     ja_total_commission,
#   )

#   # fail "#{address} com:#{commission} calc:#{calculated}" if calculated != commission

# end
# puts
# puts
# table.render
