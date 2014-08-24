require 'spec_helper'
require_relative '../lib/api_client_controller'

describe ApiClientController do
  let(:client_factory) { double(:client_factory) }
  let(:github_client)  { double(:github_client) }
  let(:repo_factory)   { double(:repo_decorator_factory) }
  let(:repo_decorator) { double(:repo_decorator) }
  let(:repos) { [repo_decorator]*3 }

  before do
    allow(client_factory).to receive(:new).with(netrc:true).and_return(github_client)
    allow(repo_factory).to receive(:new).and_return(repo_decorator)
  end

  subject { described_class.new(client_factory, repo_factory) }
  let(:github_user) { 'cybercymon' }

  describe 'getting a github user' do
    it 'asks the client for the user' do
      allow(github_client).to receive(:user).and_return(github_user)
      expect( subject.get_github_user(github_user)).to eq(github_user)
    end
  end

  describe 'getting a users github repos' do
    let(:api_client_response) { double(:api_client_response) }

    it 'asks the client for the repos' do
      allow(subject).to receive(:users_repos).and_return( [double]*3 )
      expect( subject.get_users_repos(api_client_response) ).to eq(repos)
    end
  end

  describe 'getting the repos languages' do
    let(:parallel_processor) { double(:parallel_processor) }
    let(:languages) { {:C => 1000} }
    let(:repo_decorator) { double(:repo_decorator, languages:languages) }
    let(:mapped_languages) { [languages]*3 }

    it 'parallel processes asking the api for each repos languages' do
      allow(parallel_processor).to receive(:map).and_return(mapped_languages)
      expect(subject.get_repo_languages(repos, parallel_processor)).to eq([languages]*3)
    end
  end

end
