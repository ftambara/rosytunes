module AuthenticationHelper
  def skip_header
    @skip_header = true
  end

  def skip_header?
    @skip_header || false
  end
end
