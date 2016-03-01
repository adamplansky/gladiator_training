require 'money'
class Money
  def initialize_with_default_currency(*args)
    args[0] = args[0].to_i if args[0].is_a?(String) or args[0].blank?
    args[1] ||= Money.default_currency
    initialize_without_default_currency(*args)
  end
  alias_method_chain :initialize, :default_currency
end