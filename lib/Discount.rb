
class Discount
  attr_reader :amount, :target

  def initialize (amount:, target: :global)
    self.amount = amount;
    self.target = target;
  end

  private
  attr_writer :amount
end
