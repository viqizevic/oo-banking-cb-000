class Transfer

  attr_reader :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    return if @status == "complete"
    if @sender.balance < @amount
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
    @sender.transfer(@amount)
    @receiver.deposit(@amount)
    @status = "complete"
  end

  def reverse_transfer
    if @status == "complete"
      @receiver.transfer(@amount)
      @sender.deposit(@amount)
      @status = "reversed"
    end
  end

end
