require 'spec_helper'

describe FXrate do
  before :each do
    @test_storage = double 'TestStorage'
    @test_source = double 'TestSource'
  end

  it "should be implemented" do
    expect {FXrate}.not_to raise_error
  end

  describe ".setup" do
    context "if no params were passed" do
      it "class object should have default storage and source" do
        FXrate.setup()
        expect(FXrate.storage.class).to be SQLiteStorage
        expect(FXrate.source.class).to be ECBfeed
      end
    end

    context "if storage and source were passed" do
      it "should set storage and source" do
        FXrate.setup storage: @test_storage, source: @test_source
        expect(FXrate.storage).to be @test_storage
        expect(FXrate.source).to be @test_source
      end
    end
  end

  describe ".at" do
    it "should return exchange rate for given currencies for given date" do
      FXrate.setup storage: @test_storage, source: @test_source
      @test_storage.should_receive(:get).with('GBP', Date.today) { [1] }
      @test_storage.should_receive(:get).with('USD', Date.today) { [1.5] }

      expect(FXrate.at(Date.today, 'GBP', 'USD')).to eq 1.5
    end
  end

  describe ".update" do
    before :each do
      @data = {Date.today.to_s => {"GBP" => 1, "USD" => 1.5}}
    end

    it "should retreive FX rates from source and put them into storage" do
      FXrate.setup storage: @test_storage, source: @test_source
      @test_source.should_receive(:fetch) { @data }
      @test_storage.should_receive(:save) { true }

      FXrate.update
    end
  end
end
