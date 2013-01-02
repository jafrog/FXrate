require 'spec_helper'

describe ECBfeed do
  describe ".new" do
    it "assigns url attribute if passed" do
      url = "http://test.com/test.xml"
      feed = ECBfeed.new url: url
      expect(feed.url).to eq url
    end
  end

  describe "#parse" do
    it "parses data from xml document to hash" do
      xml = '<gesmes:Envelope xmlns:gesmes="http://www.gesmes.org/xml/2002-08-01" xmlns="http://www.ecb.int/vocabulary/2002-08-01/eurofxref">'\
'<gesmes:subject>Reference rates</gesmes:subject>'\
'<gesmes:Sender>'\
'<gesmes:name>European Central Bank</gesmes:name>'\
'</gesmes:Sender>'\
'<Cube>'\
'<Cube time="2012-12-28">'\
'<Cube currency="USD" rate="1.3183"/>'\
'<Cube currency="GBP" rate="0.81695"/>'\
'</Cube>'\
'</gesmes:Envelope>'


      feed = ECBfeed.new
      expect(feed.parse(Nokogiri::XML(xml))[Date.parse("2012-12-28")]["USD"]).to eq "1.3183"
    end
  end
end
