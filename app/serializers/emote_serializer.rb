class EmoteSerializer < ApplicationSerializer
  attributes :id, :emoji, :user

  def user
    ActiveModel::SerializableResource.new(object.user, each_serializer: UserSerializer)
  end
end
