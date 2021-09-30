require_relative 'base_commission'
require_relative 'referral_fee'
require_relative 'table'

AGENT_RATES = {
# Agent Royalty  Cap    JA Cut
   ER: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.65 },
   SK: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.65 },
   BD: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.60 },
   BW: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.60 },
   CB: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.60 },
   CI: { royalty: 0.06,  cap: 0.30, ja_cut: 1.0-0.65 },
   AB: { royalty: 0.00,  cap: 0.15, ja_cut: 1.0-0.70 },
   JA: { royalty: 0.06,  cap: 0.15, ja_cut: 1.0      },
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
{ address: "Foothill Blvd 3673, Willoughby",  client: "Martin",           price: 245_000.00, commission_rate: "3 / 2 %", sheet_commission:  5_900.00, agent: :CI, source: "Market Leader",    sheet_referral:     0.00 },
{ address: "Slate Ct 1388, Cleveland Hts",    client: "Ollendieck",       price: 410_000.00, commission_rate: "4 / 3 %", sheet_commission: 13_300.00, agent: :JA, source: "Sold.com 25%",     sheet_referral: 3_325.00 },
{ address: "Monticello Dr 62, Brunswick",     client: "Bartoszek",        price: 275_000.62, commission_rate: "3 / 2 %", sheet_commission:  6_500.02, agent: :AB, source: "Sphere",           sheet_referral:     0.00 },
{ address: "Dawncliff Dr 4177, Brooklyn",     client: "Bartoszek",        price: 191_000.00, commission_rate: "4 / 3 %", sheet_commission:  6_730.00, agent: :AB, source: "Sphere",           sheet_referral:     0.00 },
{ address: "Mildred Dr 30225, Willowick",     client: "Ballard",          price: 181_500.00, commission_rate: "3 / 2 %", sheet_commission:  4_630.00, agent: :AB, source: "OpCity 35%",       sheet_referral: 1_788.50 },
{ address: "Belleshire Ave 13801, Cleveland", client: "Stephenson",       price:  99_000.00, commission_rate: "2.5 %",   sheet_commission:  2_475.00, agent: :CB, source: "Zillow - Carolee", sheet_referral:     0.00 },
{ address: "N Jester Pl 7147, Concord",       client: "Gill",             price: 200_000.00, commission_rate: "3 / 2 %", sheet_commission:  5_000.00, agent: :JA, source: "Referral - Agent", sheet_referral: 1_250.00 },
{ address: "Rainier Ct #153 5568, Parma",     client: "Yenny",            price: 128_000.00, commission_rate: "3 / 2 %", sheet_commission:  3_560.00, agent: :JA, source: "Sphere",           sheet_referral:     0.00 },
{ address: "Spokane Ave 4001, Cleveland",     client: "Baloy",            price:  79_000.00, commission_rate: "3 / 2 %", sheet_commission:  2_370.00, agent: :AB, source: "Sign Call",        sheet_referral:     0.00 },
{ address: "Menlo Rd 3597, Shaker Hts",       client: "Page",             price:  50_000.00, commission_rate: "4%",      sheet_commission:  2_000.00, agent: :JA, source: "Agent Pronto",     sheet_referral:   500.00 },
{ address: "Eagle St 534, Fairport Harbor",   client: "Passafiume",       price: 149_900.00, commission_rate: "3 / 2 %", sheet_commission:  3_998.00, agent: :AB, source: "Sphere",           sheet_referral:     0.00 },
{ address: "W Prospect Rd 1937, Ashtabula",   client: "Norman",           price: 120_000.00, commission_rate: "3  %",    sheet_commission:  3_600.00, agent: :JA, source: "Referral - Agent", sheet_referral:   900.00 },
{ address: "Whitehaven Dr 8204, Parma",       client: "Brooks",           price: 160_000.00, commission_rate: "3 / 2 %", sheet_commission:  4_200.00, agent: :CB, source: "Zillow - Carolee", sheet_referral:     0.00 },
{ address: "Sandhurst Dr 6393, Brook Park",   client: "Martin & Previts", price: 169_900.00, commission_rate: "3 / 2 %", sheet_commission:  4_398.00, agent: :CB, source: "Zillow - Carolee", sheet_referral:     0.00 },
{ address: "Tyler Ave 13618, Cleveland",      client: "Chambers",         price: 120_000.00, commission_rate: "3 / 2 %", sheet_commission:  3_400.00, agent: :CB, source: "Zillow - Carolee", sheet_referral:     0.00 },
{ address: "Oak St 12908, Garfield Hts",      client: "Marshall",         price: 102_000.00, commission_rate: "3 / 2 %", sheet_commission:  3_040.00, agent: :CB, source: "Zillow - Carolee", sheet_referral:     0.00 },
]

table = Table.new
# table.formats = [Table::STRING, Table::US_CURRENCY, Table::STRING, Table::US_CURRENCY, Table::STRING, Table::PERCENT0, Table::PERCENT0]
# table.aligns = [Table::LEFT, Table::RIGHT, Table::RIGHT, Table::RIGHT, Table::LEFT, Table::RIGHT, Table::RIGHT]
# table.headers = %w(Address Price Rate Calculated Agent Agent_Cut JA_Cut)
table.headers = [
  "Address",
  ["Price", Table::US_CURRENCY],
  "Rate",
  ["Sheet\nCommission", Table::US_CURRENCY],
  ["Calc\nCommission", Table::US_CURRENCY],
  "Agent",
  ["Agent\nCut", Table::PERCENT0],
  ["JA\nCut", Table::PERCENT0],
  "Source",
  ["Referral\nPercent", Table::PERCENT0],
  ["Sheet\nReferral", Table::US_CURRENCY],
  ["Calc\nReferral", Table::US_CURRENCY],
  ["Remaining\nCommission", Table::US_CURRENCY],
  ["Additional\nCommission", Table::US_CURRENCY],
  ["Remaining\nAdditional\nCommission", Table::US_CURRENCY],
  ["Agent\nTotal\nCommission", Table::US_CURRENCY],
  ["Agent\nRoyalty", Table::US_CURRENCY],
  ["Agent\nCap", Table::US_CURRENCY],
  ["Agent\nNet\nCommission", Table::US_CURRENCY],
  ["JA\nTotal\nCommission\n***", Table::US_CURRENCY],
]

$230.10 $0.00 $3,604.90
0.00, 0.00, 0.00
0.00, $682.50 $3,867.52
0.00, $706.65 $4,004.35
0.00, $298.36 $1,690.69
$89.10  $0.00 $1,395.90
0.00, 0.00, 0.00
0.00, 0.00, 0.00
0.00, $248.85 $1,410.15
0.00, 0.00, 0.00
0.00, $419.79  $2,378.81
0.00, 0.00, 0.00
$151.20 $0.00 $2,368.80
$158.33 $0.00 $2,480.47
$61.20  $0.00 $1,978.80
$109.44 $0.00 $1,714.56

TRANSACTIONS.each do |t|
  a = AGENT_RATES[t[:agent]]
  calculated_commission = BaseCommission.call t[:price], t[:commission_rate]
  source = SOURCES[t[:source]]
  referral = ReferralFee.new(t[:sheet_commission], source[:percent], include_additional_commission: source[:include_additional_commission])
  remaining_commission = (referral.referral_fee == t[:sheet_referral]) ? referral.remaining_commission : (calculated_commission - t[:sheet_referral])
  ja_percent = a[:ja_cut]
  agent_percent = 1.0 - ja_percent
  agent_total_commmission = remaining_commission * agent_percent
  agent_royalty = agent_total_commmission * a[:royalty]
  agent_cap = agent_total_commmission * a[:cap]
  agent_net_commission = agent_total_commmission - agent_royalty - agent_cap
  ja_total_commission = remaining_commission * ja_percent
  table.add(
    t[:address], # Address
    t[:price], # Price
    t[:commission_rate], # Rate
    t[:sheet_commission], # Sheet Commission
    calculated_commission, # Calc Commission
    t[:agent], # Agent
    agent_percent, # Agent Cut
    ja_percent, # JA Cut
    t[:source], # Source
    source[:percent], # Referral Percent
    t[:sheet_referral], # Sheet Referral
    referral.referral_fee, # Calc Referral
    remaining_commission, # Remaining Commission
    480.00, # Additional Commission
    referral.remaining_additional_commission, # Remaining Additional Commission
    agent_total_commmission, # Agent Total Commission
    agent_royalty, # Agent Royalty
    agent_cap, # Agent Cap
    agent_net_commission, # Agent Net Commission
    ja_total_commission,
  )

  # fail "#{address} com:#{commission} calc:#{calculated}" if calculated != commission

end
puts
puts
table.render
