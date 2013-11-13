require 'spec_helper'

describe "#round_up" do
  it "should round up times to the nearest 5" do
    expect(RounderHelper.round_up("1", "01")).to eq({hour: "1", minutes: "05"})
    expect(RounderHelper.round_up("1", "05")).to eq({hour: "1", minutes: "05"})
    expect(RounderHelper.round_up("1", "06")).to eq({hour: "1", minutes: "10"})
    expect(RounderHelper.round_up("12", "56")).to eq({hour: "1", minutes: "00"})
    expect(RounderHelper.round_up("1", "56")).to eq({hour: "2", minutes: "00"})
  end
end

describe "#round_minutes" do
  it "should round a number up to the nearest multiple of 5" do
    expect(RounderHelper.round_minutes(0)).to eq(0)
    expect(RounderHelper.round_minutes(1)).to eq(5)
    expect(RounderHelper.round_minutes(5)).to eq(5)
    expect(RounderHelper.round_minutes(6)).to eq(10)
  end
end

describe "#format" do
  it "should return the minutes as a double digit format" do
    expect(RounderHelper.format(0)).to eq("00")
    expect(RounderHelper.format(1)).to eq("01")
    expect(RounderHelper.format(10)).to eq("10")
  end
end