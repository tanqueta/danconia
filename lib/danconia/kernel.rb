module Kernel
  def Money(*args, **kwargs)
    Danconia::Money.new(*args, **kwargs)
  end
end
