require 'spec_helper'
require_relative '../lib/favourite_language'

describe FavouriteLanguage do

  let(:favourite_language) { "Brainfuck" }
  let(:api_client)  { double(:api_client) }
  let(:github_user) { "cybercymon" }
  subject { described_class.new(github_user, api_client) }

  it 'calls the api client and returns the favourite' do
    allow(api_client).to receive(:favourite_language_for).with(github_user).and_return(favourite_language)
    expect(subject.results).to eq(favourite_language)
  end
end

