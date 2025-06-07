# Add YAML and JSON serialization support for Danconia::Money (Rails 7+/Psych 4+ compatibility)
require 'psych'
require 'json'

module Danconia
  class Money
    # YAML serialization (Psych 4+)
    def encode_with(coder)
      coder['amount'] = amount.to_s('F')
      coder['currency'] = currency.code
      coder['decimals'] = decimals
    end

    def init_with(coder)
      @amount = BigDecimal(coder['amount'])
      @currency = Currency.find(coder['currency'])
      @decimals = coder['decimals'] || 2
    end

    # For legacy YAML.load
    def to_yaml(opts = {})
      Psych.dump(self, **opts)
    end

    # JSON serialization
    def as_json(*_args)
      {
        'amount' => amount.to_s('F'),
        'currency' => currency.code,
        'decimals' => decimals
      }
    end

    def self.json_create(hash)
      new(hash['amount'], hash['currency'], decimals: hash['decimals'])
    end
  end
end
