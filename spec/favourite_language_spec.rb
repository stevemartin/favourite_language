require 'spec_helper'
require_relative '../lib/favourite_language'

describe FavouriteLanguage do

  let(:results)            { :APL }
  let(:api_client)         { double(:api_client) }
  let(:github_user)        { 'cybercymon' }
  let(:repos)              { [double]*3 }
  let(:languages)          { [{:APL => 5, :COB0L => 4, :Python =>3}]*3 }

  subject { described_class.new(github_user, api_client) }

  before do
    allow(api_client).to receive(:get_github_user)
      .with(github_user).and_return(github_user)
    allow(api_client).to receive(:get_users_repos)
      .with(github_user).and_return(repos)
    allow(api_client).to receive(:get_repo_languages)
      .with(repos).and_return(languages)
  end

  it 'calls the api client and returns the favourite' do
    expect(subject.get).to eq(results)
  end

  context 'when there are two or more equal results' do
    let(:languages) { [{:APL => 5, :COB0L => 5, :Python =>3}]*3 }
    let(:results) { [:APL, :COB0L] }

    it 'returns the two' do
      expect(subject.get).to eq(results)
    end
  end

  context 'when the results are empty' do
    let(:languages) { [] }
    let(:results) { nil }

    it 'returns nil' do
      expect(subject.get).to eq(results)
    end
  end

  context 'when there are none for each project' do
    let(:languages) { [{}]*3 }
    let(:results) { nil }

    it 'returns nil' do
      expect(subject.get).to eq(results)
    end
  end

  context 'when there is no user matching' do
  before do
    allow(api_client).to receive(:get_github_user)
      .with(github_user).and_raise
  end

    it 'should 404' do
      expect{ subject.get }.to raise_exception("404 - User not found!")
    end
  end
end
