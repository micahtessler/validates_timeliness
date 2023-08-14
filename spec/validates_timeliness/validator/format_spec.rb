RSpec.describe ValidatesTimeliness::Validator, ":format option" do
  with_config(:use_plugin_parser, true)

  describe "for date type" do
    before do
      Person.validates_date :birth_date, format: "yyyy-mm-dd"
    end

    it "should not be valid for string given in the wrong format" do
      invalid!(:birth_date, '23/12/2023', /is not a valid date/)
    end

    it "should be valid for string given in the right format" do
      valid!(:birth_date, '2023-12-23')
    end

    it "should be valid for date instance" do
      valid!(:birth_date, Date.new(2022,12,23))
    end

    context "when the format is dd/mm/yyyy" do
      before do
        Person.validates_date :birth_date, format: "dd/mm/yyyy"
      end

      it "should be valid for string given in the right format" do
        valid!(:birth_date, '23/12/2023')
      end

      it "should not be valid for string given in the wrong format" do
        invalid!(:birth_date, '2023-12-23', /is not a valid date/)
      end

      it "should be valid for date instance" do
        valid!(:birth_date, Date.new(2022,12,23))
      end
    end
  end

  describe "for time type" do
    before do
      Person.validates_time :birth_time, format: "hh:nn:ss"
    end

    it "should not be valid for string given in the wrong format" do
      invalid!(:birth_time, "00-00-00", /is not a valid time/)
    end

    it "should be valid for string given in the right format" do
      valid!(:birth_time, "00:00:00")
    end

    it "should be valid for date instance" do
      valid!(:birth_time, Time.new(2010, 1, 1, 0, 0, 0))
    end

    context "when the time format is 'ss-nn-hh' " do
      before do
        Person.validates_time :birth_time, format: "ss-nn-hh"
      end

      it "should be valid for string given in the right format" do
        valid!(:birth_time, '23-34-01')
      end

      it "should not be valid for string given in the wrong format" do
        invalid!(:birth_time, '01:34:23', /is not a valid time/)
      end

      it "should be valid for date instance" do
        valid!(:birth_time, Time.new(2010, 1, 1, 1, 34, 23))
      end
    end
  end

  describe "for datetime type" do
    before do
      Person.validates_datetime :birth_datetime, format: "yyyy-mm-dd hh:nn:ss"
    end

    it "should not be valid for string given in the wrong format" do
      invalid!(:birth_datetime, "01-01-2010 00-00-00", /is not a valid datetime/)
    end

    it "should be valid for string given in the right format" do
      valid!(:birth_datetime, "2010-01-01 00:00:00")
    end

    it "should be valid for date instance" do
      valid!(:birth_datetime, DateTime.new(2010, 1, 1, 0, 0, 0))
    end

    context "when the datetime format is 'ss/nn/hh/dd/mm/yyyy' " do
      before do
        Person.validates_datetime :birth_datetime, format: "ss/nn/hh/dd/mm/yyyy"
      end

      it "should be valid for string given in the right format" do
        valid!(:birth_datetime, "00/00/00/01/01/2010")
      end

      it "should not be valid for string given in the wrong format" do
      invalid!(:birth_datetime, "2010-01-01 00:00:00", /is not a valid datetime/)
      end

      it "should be valid for date instance" do
        valid!(:birth_datetime, DateTime.new(2010, 1, 1, 0, 0, 0))
      end
    end
  end
end
