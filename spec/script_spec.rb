require 'spec_helper'
require './script'

describe GetFavoriteLanguage do

  let(:github_user) { "stevemartin" }
  subject { described_class.new(github_user) }

  it "returns my favorite language" do
    expect( subject.result ).to eq("Ruby")
  end

  context "with a different username" do
    let(:github_user) { "torvalds" }

    it "returns Linus' favorite language" do
      expect( subject.result ).to eq("C")
    end
  end

end
