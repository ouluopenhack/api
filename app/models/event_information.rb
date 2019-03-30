class EventInformation

  class << self
    def starts_at
      START_DATE
    end

    def ends_at
      END_DATE
    end

    def venue
      VENUE
    end
  end

  private
    START_DATE = Time.zone.local(2019,3,30,19, 00).freeze
    END_DATE = Time.zone.local(2019,3,31,17,00).freeze
    VENUE = "Business Kitchen Tellus, University of Oulu"
end