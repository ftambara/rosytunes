class MusicLibraryGateway
  def list_of(model_class, query, persist: true)
    return [] if query.nil? || query.blank?
    mapper = model_class.api_mapper
    results = mapper.api_class.search(query)
    results.map { |result| mapper.api_to_app_model(result, persist:) }
  end

  def find(model)
    mapper = model.class.api_mapper
    result = mapper.api_class.find(model.api_id)
    mapper.transfer_into_model(result, model)
  end
end
