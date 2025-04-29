module PaperTrail
  PaperTrail.serializer = PaperTrail::Serializers::JSON

  class Version
    def present
      @presenter ||= TrailPresenter.new(self)
    end
  end
end
