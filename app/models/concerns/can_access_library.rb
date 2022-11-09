module CanAccessLibrary
  def search(query)
    gateway.list_of(mb_adapter, matching: query)
  end

  def mb_adapter
    raise NotImplementedError
  end

  private
    def gateway
      raise NotImplementedError
    end
end
