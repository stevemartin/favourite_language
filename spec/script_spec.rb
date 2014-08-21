require 'spec_helper'
require './script'

describe GetFavoriteLanguage do

  subject { described_class.new "stevemartin" }

  it "should return my favorite language" do
    expect( subject.result ).to eq("Ruby")
  end

end
