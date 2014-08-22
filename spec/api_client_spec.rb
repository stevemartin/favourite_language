require 'spec_helper'
require_relative '../lib/api_client'

describe ApiClient do
  let(:github_client) { double(:github_client) }

  before do
    allow(github_client).to receive(:new)
  end

  it 'authenticates the client' do
    described_class.new(github_client)
  end

  describe 'finds the favorite language for a github user' do
    subject { described_class.new(github_client) }
    let(:github_user) { 'cybercymon' }

    context 'when the user exists' do
      let(:repos) { Hash.new }
      before do
        allow(github_client).to receive(github_user).and_return(Hash.new)
        allow(subject).to receive(:get_users_repos).and_return(repos)
      end
      it 'gets the users favourite language' do
        subject.favourite_language_for(github_user)
      end
    end

    context 'when the user doesnt exist' do
      before do
        allow(github_client).to receive(github_user).and_raise
      end
      it 'returns a 404 - resource not found' do
        subject.favourite_language_for(github_user)
      end
    end
  end
end
