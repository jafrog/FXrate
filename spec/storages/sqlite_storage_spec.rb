require 'spec_helper'

describe SQLiteStorage do
  before :each do
    # @db = double 'SQLite3::Database'
    @storage = SQLiteStorage.new
  end

  describe ".new" do
    it "should create database" do
      expect(@storage.db.class).to be SQLite3::Database
    end
  end

  describe "#get" do
    it "should return fx rate for given currency and date" do
      SQLite3::Database.any_instance.should_receive(:execute) {1}
      expect(@storage.get('GBP')).to eq 1
    end
  end

  describe "#save" do
    it "should parse data hash and save it to db" do
      data = {Date.today => {"GBP" => 1, "USD" => 1.5}}
      SQLite3::Database.any_instance.should_receive(:execute).at_least(:once)
      @storage.save(data)
    end
  end
end
