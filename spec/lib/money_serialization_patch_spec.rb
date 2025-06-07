require 'danconia/money'
require 'yaml'
require 'json'

RSpec.describe Danconia::Money do
  let(:money) { described_class.new('123.45', 'USD', decimals: 2) }

  it 'serializes and deserializes to YAML' do
    yaml = YAML.dump(money)
    loaded = YAML.safe_load(yaml, permitted_classes: [Danconia::Money, BigDecimal], aliases: true)
    expect(loaded).to be_a(Danconia::Money)
    expect(loaded.amount).to eq(BigDecimal('123.45'))
    expect(loaded.currency.code).to eq('USD')
    expect(loaded.decimals).to eq(2)
  end

  it 'serializes and deserializes to JSON' do
    json = money.to_json
    loaded = Danconia::Money.json_create(JSON.parse(json))
    expect(loaded).to be_a(Danconia::Money)
    expect(loaded.amount).to eq(BigDecimal('123.45'))
    expect(loaded.currency.code).to eq('USD')
    expect(loaded.decimals).to eq(2)
  end
end
