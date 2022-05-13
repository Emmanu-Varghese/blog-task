module Filterable
  def filter!(resource)
    apply_filters(resource)
  end

  private

  def filter_params_for(resource)
    params.permit(resource::FILTER_PARAMS)
  end

  def apply_filters(resource)
    resource.filter(filter_params_for(resource))
  end
end
