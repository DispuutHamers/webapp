module PaperTrail
  PaperTrail.serializer = PaperTrail::Serializers::JSON

  class Version < ActiveRecord::Base
    def present
      @presenter ||= TrailPresenter.new(self)
    end
  end
end
